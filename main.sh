#!/bin/bash
Path=$PWD/DBs
export Path
PS3="Please Enter Your Option :";
select opt in "Create Database" "List All Databases" "Connect Database" "Drop Database" "Exit"
do
    case $REPLY in 
        1) . ./createDB.sh;;
        2) ls  $Path;;
        3) . ./connectDB.sh;;
        4) . ./dropDB.sh;;
        5) exit;;
        *) echo "Not an Option !!";;
    esac
done
