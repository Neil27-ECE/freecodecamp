#!/bin/bash
PSQL="psql --username=freecodecamp --dbname=number_guessing_game -t --no-align -c"

MAIN_QUESTION() {
  read GUESS
}
SECRET_NUMBER=$((1 + RANDOM % 1000))

echo -e "\nEnter your username:\n"
read USERNAME
USER_NAME=$($PSQL "SELECT username FROM guessing_user WHERE username='$USERNAME'")
GAMES_PLAYED=$($PSQL "SELECT COUNT(number_of_guesses) FROM user_history INNER JOIN guessing_user USING(user_id) WHERE username='$USERNAME'")
BEST_GAME=$($PSQL "SELECT MIN(number_of_guesses) FROM user_history INNER JOIN guessing_user USING(user_id) WHERE username='$USERNAME'")
if [[ -z $USER_NAME ]]
then
  echo -e "\nWelcome, $USERNAME! It looks like this is your first time here.\n"

  USER_NAME_RESULT=$($PSQL "INSERT INTO guessing_user(username) VALUES('$USERNAME')")
else
  echo -e "\nWelcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses.\n"
fi

echo -e "\nGuess the secret number between 1 and 1000:\n"
MAIN_QUESTION

for (( i=1; $GUESS != $SECRET_NUMBER; i++ ))
do
  TRIALS=$((1 + $i))
  if [[ ! $GUESS =~ ^[0-9]+$ ]]
  then
    echo -e "\nThat is not an integer, guess again:\n"
    MAIN_QUESTION
  fi

  if [[ $GUESS -lt $SECRET_NUMBER ]]
  then
    echo -e "\nIt's higher than that, guess again:\n"
    MAIN_QUESTION
  else
    echo -e "\nIt's lower than that, guess again:\n"
    MAIN_QUESTION
  fi

  if [[ $GUESS -eq $SECRET_NUMBER ]]
  then
    echo -e "\nYou guessed it in $TRIALS tries. The secret number was $SECRET_NUMBER. Nice job!\n" 
    USER_ID=$($PSQL "SELECT user_id FROM guessing_user WHERE username='$USERNAME'")
    GUESSING_RESULT=$($PSQL "INSERT INTO user_history(user_id, number_of_guesses)  VALUES($USER_ID,$TRIALS)")
  fi
done

