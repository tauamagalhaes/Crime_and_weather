###### Raw Dataset of Rio de Janeiro Crime

# Since this a closure dataset from the Insitute of Public Security of Rio de Janeiro,
# it is not possible for me to make public. So the daily crime data was compiled using 
# the following steps.

#### Packages
library(tidyverse)
library(readxl)

#### Setting working directory
setwd("/Users/tauamagalhaes/Documents/Crime_and_rain")

#### Loading the data
## Crime data 
data_crime_RJ <- read_excel("Roubo_e_furto_RJ.xlsx")
## Weather data
data_weather <- read_excel("Dados_meteorologicos.xlsx")


### Theft and robbery of vehicles
# Filtering for the type of crime
theft_cars <- data_crime_RJ %>% filter(titulo_do == "Furto de veículos" |  titulo_do == "Roubo de veículo")
# Filtering for the city of Rio de Janeiro only
theft_cars <- theft_cars %>% filter(municipio_fato == "Rio de Janeiro")
# Changing the format for date type
theft_cars$data_com <- as.Date(theft_cars$data_com, "%Y-%m-%d")
## Counting the number of observations per day
count_theft <- theft_cars %>%
  count(Date = as.Date(data_com))%>%
  group_by(Date) %>% 
  complete(Date, fill = list(n = 0)) %>%
  arrange(Date)
# Renaming the column
names(count_theft)[2] <- "theft"
# Subseting for only 2016 and January 2017
theft <- subset(count_theft, Date > "2015-12-31")
theft <- subset(theft, Date < "2017-02-01")

### Weather data
# Changing for date format
data_weather$Data <- as.Date(data_weather$Data, "%d/ %m/ %Y")
# Subsetting for only 2016 and January 2017
weather <- subset(data_weather, Data > "2015-12-31" )
weather <- subset(weather, Data < "2017-02-01")
# Subsetting for only the important features
weather <- weather[c("Data", "Precipitacao", "Temp Comp Media", 
                     "Umidade Relativa Media", "Velocidade do Vento Media")]
# Aggregating by day
weather <- aggregate(list(weather$Precipitacao, weather$`Temp Comp Media`,
                          weather$`Umidade Relativa Media`, weather$`Velocidade do Vento Media`),
                     by = list(weather$Data), FUN = "sum", na.rm = TRUE)
names(weather)[1] <- "date"
names(weather)[2] <- "rain"
names(weather)[3] <- "temperature"
names(weather)[4] <- "humidity"
names(weather)[5] <- "wind"

#### Merging in a single dataset
crime_data <- merge(theft, weather, by.x = "Date", by.y = "date")

#### Exporting the data
write.csv(crime_data, "/Users/tauamagalhaes/Documents/Crime_and_rain/crime_data.csv")
