# Project Title: Weather_App
Weather_App is scripting application designed to fetch weather forecasts for a specific location and display the weather information in the terminal. This app also includes API Intergration, Unit Conversion e.t.c.

## Features
+ Location Input
  ~~~
   Allow user to enter their location.
  ~~~
 
+ API Integration
  ~~~
   Using curl to make HTTP requests to a weather API.
  ~~~
 
+ Display Weather Data
  ~~~
   Displaying the retrieved weather data in the terminal. For JSON Parsing we use 'jq' a command-line JSON Processor, to extract specific fields from the API response.
  ~~~
 
+ Unit Conversion
  ~~~
   Providing options for user to select units. Eg: Celsuis or Fahrenheit
  ~~~
  
+ Error Handling
  ~~~
   Conditional statements and error checking techniques to handle issuses like invalid location input or failed API requests.
  ~~~
 
+ Interactive Features
  ~~~
   Using loops to allow user to check weather for multiple locations sequentially.
  ~~~
  
+ Forecast
  ~~~
   Giving users the opportunity to see the weather forecast for one or more days after current day.
  ~~~
