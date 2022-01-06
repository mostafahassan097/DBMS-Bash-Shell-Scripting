#!/bin/bash
#Check DateType
function checkDataType() {
datatype=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "`

if [[ "$datatype" == *"int"* ]]
then
	num='^[0-9]+$'	
	if ! [[ $2 =~ $num ]]
	then
		echo "Please Enter Numbers Only !!"
		return 1
	else
		checkPK $1 $2
	fi
elif [[ "$datatype" == *"string"* ]]
then
	str='^[:space:]]+[a-zA-Z]$'
	if ! [[ $2 =~ $str ]]
	then
		echo "False input: Not a valid string!"
		return 1
	else
		checkPK $1 $2
	fi
fi
}

#Check Primary Key function
function checkPK() {
header=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "`
if [[ "$header" == *"PK"* ]]; then if [[ `cut -f$1 -d" " $Path/$DBname/$TBname | grep -w $2` ]]
then
	echo $'\nPrimary Key already exists. no duplicates allowed!' 
	return 1
fi
fi
}

