#!/bin/bash

#Check DateType
function checkType {
datatype=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "`
if [[ "$datatype" == *"int"* ]]
then
	num='^[0-9]+$'
	if ! [[ $2 =~ $num ]]
	then
		echo "False input: Not a number!"
		return 1
	else
		checkPK $1 $2
	fi
elif [[ "$datatype" == *"string"* ]]
then
	str='^[a-zA-Z]+$'
	if ! [[ $2 =~ $str ]]
	then
		echo "False input: Not a valid string!"
		return 1
	else
		checkPK $1 $2
	fi
fi
}
#Check Primary Kry function

function checkPK {
header=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "`
if [[ "$header" == *"PK"* ]]; then if [[ `cut -f$1 -d" " $Path/$DBname/$TBname | grep -w $2` ]]
then
	echo $'\nPrimary Key already exists. no duplicates allowed!' 
	return 1
fi
fi
}

echo "Please Enter database name to connect it: "
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
		echo "no database with $DBname name"
		echo $'\nDo you want to create it? [y/n]\n'
		read answer
		case $answer in
			y)
			./createDB.sh;;
			n)
			./connectDB.sh;;
			*)
			echo "Back To Main Menu.." ;
			sleep 2
			clear;
			./main.sh;;	
		esac
   
    fi;
else
    echo "Sorry Database Name Must Be Only Alphabet !!";
    sleep 2;
    . ./createDB.sh;
fi;



















