#!/bin/bash
echo "Please enter table name to delete from: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
	echo $'\n'
	echo "Please enter field number to find value: "
	read field
	echo $'\n'
	echo "Please enter field value to delete record(s): "
	read value
	echo $'\n'
	if cut -f$field -d" " $Path/$DBname/$TBname | grep -w -q ${value} 
	then
		gawk -v gValue=$value -v gField=$field -i inplace '{ gsub(gValue, "deleteThis", $gField) }; { print }' $Path/$DBname/$TBname
		sed -i '/deleteThis/d' $Path/$DBname/$TBname
		echo $'Record(s) deleted successfully!\n'
	else
		echo $'No such entry in that column!\n'
		./deleteTB.sh
	fi
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [Y/N]"
	read answer
	case $answer in
		Y)
		./createTB.sh ;;
		N)
		./deleteTB.sh ;;
		*)
		echo "Incorrect answer. Redirecting to main menu.." ;
		sleep 2;
		./main.sh;;			
	esac
	fi