#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE TABLE games, teams;")
cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != "year" ]]
  then
    #get winner id
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    #if not found insert into teams
    if [[ -z $WINNER_ID ]]
    then
      INSERT_WINNER_RESULTS=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER');")
      if [[ $INSERT_WINNER_RESULTS == "INSERT 0 1" ]]
      then
        echo Inserted into teams, "$WINNER"
      fi
      #get new winner id
      WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER';")
    fi
    #get opponent id
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    #if not found insert into teams
    if [[ -z $OPPONENT_ID ]]
    then
      INSERT_OPPONENT_RESULTS=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT');")
      if [[ $INSERT_OPPONENT_RESULTS == "INSERT 0 1" ]]
      then
        echo Inserted into teams, "$OPPONENT"
      fi
      #get new opponent id
      OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT';")
    fi
    #insert all into games
    INSERT_GAMES_RESULTS=$($PSQL "INSERT INTO games(year, round, winner_goals, opponent_goals, winner_id, opponent_id) VALUES($YEAR, '$ROUND', $WINNER_GOALS, $OPPONENT_GOALS, $WINNER_ID, $OPPONENT_ID);")
    if [[ $INSERT_GAMES_RESULTS == "INSERT 0 1" ]]
    then
      echo Inserted into games, $YEAR $ROUND $WINNER_GOALS $OPPONENT_GOALS $WINNER_ID $OPPONENT_ID
    fi
  fi
done