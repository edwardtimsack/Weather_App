#! /bin/bash
echo
echo "WEATHER APP"
echo "Hello $(whoami)"
echo

# Prompt user to enter city
function userCity(){
    echo "Want to know the weather?"
    read -p "Enter City: " USER_CITY
    echo
}
userCity

# Prompt user to enter the day the want the weather for
function userDay(){
    echo ""
    sleep 1
    echo "Weather for when?"
    echo "A) Today" 
    echo "B) Tomorrow" 
    echo "C) Day After Tomorrow"
    read -p "Enter Day: " USER_DAY

    # Validate user inputs
    if [[ $USER_DAY == "a" || $USER_DAY == "A" ]]
    then
        USER_DAY=1
    elif [[ $USER_DAY == "b" || $USER_DAY == "B" ]]
    then
        USER_DAY=2
    elif [[ $USER_DAY == "c" || $USER_DAY == "C" ]]
    then
        USER_DAY=3
    else
        echo "Wrong input. You can only enter \"a, b, c\" or \"A, B, C\""
        userDay
    fi
}
userDay

# Get weather data from API
function getData(){
API_KEY="8f920a708a6e478aafa21737230811"  # My API_KEY from WeatherApi
API_URL="http://api.weatherapi.com/v1/forecast.json?key=$API_KEY&q=$USER_CITY&aqi=no&days=$USER_DAY" # OpenWeatherMap API URL
response=$(curl -s "$API_URL") # Making a GET request to the Weather API
# echo "$response" 

# Checking if city is valid
  if [[ $(echo "$response" | jq -r ".error.code") -eq 1006 ]]
    then
        echo
        echo "      NOTE: City not found! Please try again."
        echo
        userCity
        userDay
        getData
    else
        # Search through the API and store relevant data in clearly named variables
        forecast=$(echo "$response" | jq -r ".forecast.forecastday[$(($USER_DAY -1))]")
        country=$(echo "$response" | jq -r ".location.country")
        date=$(echo "$forecast" | jq -r ".date")
        text=$(echo "$forecast" | jq -r ".day.condition.text")
        image=$(echo "$forecast" | jq -r ".day.condition.icon")
        temperature_celsuis=$(echo "$forecast" | jq -r ".day.avgtemp_c")
        temperature_fahrenheit=$(echo "$forecast" | jq -r ".day.avgtemp_f")
        humidity=$(echo "$forecast" | jq -r ".day.avghumidity")
        wind_direction=$(echo "$forecast" | jq -r '.current.wind_dir')

       
        # Adding data to tables
        echo "      WEATHER DETAILS" > weather.csv
        echo "      COUNTRY: $country" >> weather.csv
        echo "      DATE: $date" >> weather.csv
        echo "      CONDITION: $text" >> weather.csv
        echo "      TEMPERATURE: $temperature_celsuis ॰C / $temperature_fahrenheit ॰F" >> weather.csv
        echo "      HUMIDITY: $humidity" >> weather.csv
        echo
        curl -s "https:$image" | imgcat
        cat weather.csv   
        echo  
    fi 
}
getData
