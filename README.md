# Crime and weather

As crime rate increases in Brazil, the topic has risen to one of the major concerns in the domestic policy agenda, 
so has the need to relevant empirical discoverings that can explain the phenomenon. Weather is one variable that is mostly neglected 
in behaviour criminlogical theories.

In this repository, I used time series models to address the relation between property crime and weather for the city of Rio de Janeiro. 
Daily data for the year of 2016 were used to make short-term forecasting of property crime to the first month of 2017.

The data was compiled using the police reports of the Public Security Office in Rio de Janeiro (ISP-RJ). Since, this data is confidential
I made public only the aggregated data by day. However, if anyone is interested in requesting the raw data of police reports, the R script 
can be used to get to the time series used. The weather data is available in the INMET website.

The results show that including a ten days moving average in a classical ARIMA model improves the accuracy of the predictions. This can be interpreted as
an evidence of relation between the two. LSTM neural net showed a better accuracy in the predictions when compared to the classical approaches.
