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

    # Validate user input
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

    # Validate user input
    if [[ $USER_DAY == "a" || $USER_DAY == "A" ]]
    then
        USER_DAY=Graph
    elif [[ $USER_DAY == "b" || $USER_DAY == "B" ]]
    then
        USER_DAY=Table
    else
        echo "Wrong input. You can only enter \"a, b\" or \"A, B\""
        displayFormat
    fi
    echo
}
displayFormat


echo "You want to know the weather of $USER_CITY for $USER_DAY in a $DISPLAY_FORMAT format."