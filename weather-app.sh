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
    echo "a)Today b)Tomorrow c)Day After Tomorrow"
    read -p "Enter Day: " USER_DAY

    # Validate user inputs
    if [[ $USER_DAY == "a" || $USER_DAY == "A" ]]
    then
        USER_DAY=Today
    elif [[ $USER_DAY == "b" || $USER_DAY == "B" ]]
    then
        USER_DAY=Tomorrow
    elif [[ $USER_DAY == "c" || $USER_DAY == "C" ]]
    then
        USER_DAY="Day After Tomorrow"
    else
        echo "Wrong input. You can only enter \"a, b, c\" or \"A, B, C\""
        userDay
    fi
}
userDay

# Prompt user to enter theformat the want the weather in
function displayFormat(){
    echo ""
    echo "a)Graph b)Table"
    read -p "Enter Display Format: " DISPLAY_FORMAT

    # Validate user inputs
    if [[ $DISPLAY_FORMAT == "a" || $DISPLAY_FORMAT == "A" ]]
    then
        DISPLAY_FORMAT=Graph
    elif [[ $DISPLAY_FORMAT == "b" || $DISPLAY_FORMAT == "B" ]]
    then
        DISPLAY_FORMAT=Table
    else
        echo "Wrong input. You can only enter \"a, b\" or \"A, B\""
        displayFormat
    fi
    echo
}
displayFormat


echo "You want to know the weather of $USER_CITY for $USER_DAY in a $DISPLAY_FORMAT format."
echo


# My API_KEY from WeatherApi
API_KEY="8f920a708a6e478aafa21737230811"

# OpenWeatherMap API URL
API_URL="http://api.weatherapi.com/v1/current.json?key=8f920a708a6e478aafa21737230811&q=$USER_CITY&aqi=no"


# Making a GET request to the Weather API
response=$(curl -s "$API_URL")
# echo "$response" 


country=$(echo "$response" | jq -r '.location.country')
localtime=$(echo "$response" | jq -r '.location.localtime')
text=$(echo "$response" | jq -r '.current.condition.text')
image=$(echo "$response" | jq -r '.current.condition.icon')
temperature_celsuis=$(echo "$response" | jq -r '.current.temp_c')
temperature_farenheit=$(echo "$response" | jq -r '.current.temp_f')
humidity=$(echo "$response" | jq -r '.current.humidity')
wind_direction=$(echo "$response" | jq -r '.current.wind_dir')

echo "Country's Name: $country"
echo
echo "Country's Localtime: $localtime"
echo
echo "Weather is $text"
echo
curl -s "https:$image" | imgcat
echo
echo "$temperature_celsuis ॰C"
echo
echo "$temperature_farenheit ॰F"
echo
echo "Humidity: $humidity"
echo
echo "Wind's Direction: $wind_direction"

