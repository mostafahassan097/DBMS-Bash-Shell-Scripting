#!/bin/bash
#Functions To Validate DataType And Primary Key


echo "Please Enter Database Name To Connect It :"
read DBname
if  [[ $DBname =~ ^[a-zA-Z]+$ ]]
then
    if [ -d $Path/$DBname ]
    then 
    echo "You Connected Succesfully To $DBname";
	PS3="Please Enter Your Option :";
	select opt in "Create Table" "List All Tables" "Drop Table" "Insert Into Table" "Select From Table" "Delete From Table" "Update Table" "Back to Menu"
	do
		case $REPLY in 
			1) . ./createTB.sh;;
			2) ls  $Path/$DBname ;;
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
		echo "No Database With This Name $DBname"
		echo $'\nDo You Want Create It ? [y/n]\n'
		read answer
		case $answer in
			y)
			. ./createDB.sh;;
			n)
			. ./connectDB.sh;;
			*)
			echo "Back To Main Menu.." ;
			sleep 2
			clear;
			 . ./main.sh;;	
		esac
   
    fi;
else
    echo "Sorry Database Name Must Be Only Alphabet !!";
    sleep 2;
    . ./createDB.sh;
fi;



















