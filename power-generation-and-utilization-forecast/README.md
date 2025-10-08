# Prediction-on-Renewable-energy-generation-
    
The Main aim of this project isto Predict the Renewable(Solar,Wind) power generation on daily basis andthe load usage of this power generation and Renewable energy is a revolutionary topic today, dwindling the usage of non-renewable energy is the main concern.   Every organization working on analyzing the data on renewable energy for further use, or to increase supply. I have  analyzed PJM region energy load, which helps organizations by enabling them to recognize the patterns in the data, and by showing insights into untapped information.  I have took the  advantage of different forecasting models to forecast energy usage hourly, where FB-Prophet has shown promising results. I have considered 4 years of historical data for training and testing purpose. PJM has provided us with abundance of historical data, which helped me to work on model.
   
  ### From PJM I have various features to consider are as follows:

- Evaluated At UTC: Evaluating megawatts in Universal time.
- Evaluated At EPT: Evaluating megawatts in eastern prevailing time.
- Datetime Beginning UTC: Beginning of energy consumption in Universal time.
- Datetime Beginning EPT: Beginning of energy consumption in eastern prevailing time.
- Datetime Ending EPT: Ending of energy consumption in eastern prevailing time.
- Datetime Ending UTC: Ending of energy consumption in Universal time.
- Forecast Area: Region in which forecasting is done.
- Forecast MW: How much energy (mw) is used.
- We do forecast on this data; hence we must take time series from features. And region is an important concern to show usage in respective areas.
 ### Our important features are:
- Datetime Beginning EPT/UTC, Datetime Ending EPT/UTC, Forecast Region and Forecast time,power generation/Load usage.
