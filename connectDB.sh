#!/bin/bash

	echo "Please Enter database name to connect it: "
	read DBname
	if [[ -d $Path ]]
	then 
	       clear
	       echo "Connect Successfully To $DBname "
PS3="Please Enter Your Option :";
select opt in "Create Table" "List All Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back to Menu"
do
    case $REPLY in 
        1) . ./createTB.sh;;
        2) ls  $Dbname;;
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
else 
		echo "no database with $DBname name"
		echo $'\nDo you want to create it? [y/n]\n'
		read answer
		case $answer in
			y)
			./createDB.sh;;
			n)
			./connectDB.sh;;
			*)
			echo "Incorect answer, Redirecting to main menu.." ;
			sleep 2
			./main.sh;;	
		esac
	fi	