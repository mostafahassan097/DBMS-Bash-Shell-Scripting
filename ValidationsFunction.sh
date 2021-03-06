#!/bin/bash
#Check DateType
function checkDataType() {
datatype=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "` #print one of feild for ex :name:string: 

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
elif [[ "$datatype" == *"string"* ]] #match if wor string exist in datatype variable 
then
	str='^[a-zA-Z]+$'
	#str='[[:space:]]+[[alpha]]$'
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
header=`grep PK $Path/$DBname/$TBname | cut -f$1 -d" "` #return all feild that containing primary key
if [[ "$header" == *"PK"* ]]
then 
	if [[ `cut -f$1 -d" " $Path/$DBname/$TBname | grep -w $2` ]]
	then
		echo $'\nPrimary Key already exists. no duplicates allowed!' 
		return 1
	fi
fi
}

