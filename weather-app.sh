#! /bin/bash

# read -p "Download dependencies y/n: " USER_RESPONSE

# if [[ $USER_RESPONSE == "y"  || $USER_RESPONSE == "Y" ]]
#     then    
#         sudo apt install -y jq
#         sudo snap install -y imgcat
#         sudo apt install -y curl
# else
#     exit 0
# fi

# dsfvbz hm fb

#!/bin/bash

# Function to check if a command is available
function command_exists() {
    command -v "$1" >/dev/null 2>&1
}


    read -p "Download dependencies? (y/n): " USER_RESPONSE

# Check if dependencies are already installed
    if command_exists jq && command_exists imgcat && command_exists curl; then
    echo "Dependencies are already installed."  
    else
    if [[ $USER_RESPONSE == "y" || $USER_RESPONSE == "Y" ]]; then
        # Install dependencies
        sudo apt install -y jq
        sudo snap install -y imgcat
        sudo apt install -y curl
    else
        echo "Exiting without installing dependencies."
        exit 0
    fi
fi

# Rest of your script...







function greeting() {
    echo
    echo "WEATHER APP"
    echo "Hello $(whoami)"
    echo
}
greeting

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
    fi 
}
getData


echo
curl -s "https:$image" | imgcat
echo  "   $text"

# Display weather data
function displayData(){

    function displayTemperature(){
        awk '/TEMPERATURE:/ {print $0}' weather.csv
    }
    function displayHumidity(){
        grep "HUMIDITY:" weather.csv
    }
    function searchData(){
        echo
        read -p "      Search : " USER_SEARCH
        echo
        grep -iw "$USER_SEARCH" weather.csv
    }

    function viewData(){
        column weather.csv
    }
    # Display options to users
    echo
    echo
    echo "      OPTIONS"
    echo "      A) View Temperature"
    echo "      B) View Humidity" 
    echo "      C) Search"
    echo "      D) View All"
    echo "      E) Home"

    read -p "      Enter Option: " USER_OPTIONS
    echo

    # Validate user inputs
    if [[ $USER_OPTIONS == "a" || $USER_OPTIONS == "A" ]]
    then
        displayTemperature
        sleep 2
        displayData
    elif [[ $USER_OPTIONS == "b" || $USER_OPTIONS == "B" ]]
    then
        displayHumidity
        sleep 2
        displayData
    elif [[ $USER_OPTIONS == "c" || $USER_OPTIONS == "C" ]]
    then
        searchData
        sleep 2
        displayData
    elif [[ $USER_OPTIONS == "d" || $USER_OPTIONS == "D" ]]
    then
        viewData
        sleep 2
        displayData
    elif [[ $USER_OPTIONS == "e" || $USER_OPTIONS == "E" ]]
    then
        greeting
        userCity
        userDay
        getData
        displayData
    else
        echo "      Wrong input. You can only enter \"a, b, c, d, e\" or \"A, B, C, D, E\""
        sleep 2
        displayData
    fi
    echo 
}
displayData