#!/bin/bash
PSQL="psql -X --username=freecodecamp --dbname=periodic_table --no-align -t -c"

if [[ $1 ]]
then
  ARG="$1"
  if [[ $ARG =~ ^[0-9]+$ ]]
  then
    ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$ARG")
    ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$ARG")
    SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$ARG")
    TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types USING(type_id) WHERE atomic_number=$ARG")
    ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$ARG")
    MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$ARG")
    BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$ARG")
    if [[ -z $ATOMIC_NUMBER ]]
    then
     echo -e "I could not find that element in the database." 
    else
      echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
    fi
  else
    if [[ $ARG =~ ^[a-zA-Z]{1,2}$ ]]
    then
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$ARG'")
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$ARG'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$ARG'")
      TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE symbol='$ARG'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$ARG'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$ARG'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE symbol='$ARG'")
      if [[ -z $SYMBOL ]]
      then
        echo -e "I could not find that element in the database." 
      else
        echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    else
      ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$ARG'")
      ELEMENT_NAME=$($PSQL "SELECT name FROM elements WHERE name='$ARG'")
      SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$ARG'")
      TYPE=$($PSQL "SELECT type FROM types INNER JOIN properties USING(type_id) INNER JOIN elements USING(atomic_number) WHERE name='$ARG'")
      ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$ARG'")
      MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$ARG'")
      BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements USING(atomic_number) WHERE name='$ARG'")
      if [[ -z $ELEMENT_NAME ]]
      then
        echo -e "I could not find that element in the database." 
      else
        echo -e "The element with atomic number $ATOMIC_NUMBER is $ELEMENT_NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $ELEMENT_NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
      fi
    fi
  fi

else
  echo -e "Please provide an element as an argument."
fi