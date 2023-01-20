#install.packages("prophet")
library(prophet)

# Load the data
# data frame with columns ds and y, containing the date and numeric value respectively.
# The ds column should be YYYY-MM-DD for a date, or YYYY-MM-DD HH:MM:SS for a timestamp.
df <- read.csv('https://raw.githubusercontent.com/facebook/prophet/main/examples/example_wp_log_peyton_manning.csv')

# Call the prophet function to fit the model
m <- prophet(df)

# Predictions are made on a dataframe with a column ds containing the dates for
#which predictions are to be made. The make_future_dataframe function takes the 
# model object and a number of periods to forecast and produces a suitable dataframe.
#By default it will also include the historical dates so we can evaluate in-sample fit.
future <- make_future_dataframe(m, periods = 365)
tail(future)

# As with most modeling procedures in R, we use the generic predict function to 
# get our forecast. The forecast object is a dataframe with a column yhat containing
# the forecast. It has additional columns for uncertainty intervals and seasonal components.
forecast <- predict(m, future)
tail(forecast[c('ds', 'yhat', 'yhat_lower', 'yhat_upper')])

# You can use the generic plot function to plot the forecast, by passing in the 
# model and the forecast dataframe.
plot(m, forecast)

# You can use the prophet_plot_components function to see the forecast broken 
#down into trend, weekly seasonality, and yearly seasonality.
prophet_plot_components(m, forecast)

# An interactive plot of the forecast using Dygraphs can be made with the command
dyplot.prophet(m, forecast)
