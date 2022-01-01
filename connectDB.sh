#!/bin/bash
PS3="Please Enter Your Option :";
select opt in "Create Table" "List All Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back to Menu"
do
    case $REPLY in 
        1) . ./createTB.sh;;
        2) ls  /DBs/;;
        3) . ./dropTB.sh;;
        4) . ./insertTB.sh;;
        5) . ./selectTB.sh;;
        6) . ./deleteTB.sh;;
        7) . ./updateTB.sh;;
        8) . ./main.sh;;
        9) exit;;
        *) echo "Not an Option !!";;
    esac
done
