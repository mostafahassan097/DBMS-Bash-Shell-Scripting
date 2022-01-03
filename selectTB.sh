#!/bin/bash
echo "Please enter table name to select data: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
        awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
        echo $'\nWould you like to print all records? [y/n]'
        read printall
        if [[ $printall == "Y" || $printall == "y" || $printall == "yes" ]]
        then
        	echo $'\nWould you like to print a specific field? [y/n]'
		read cut1
		if [[ $cut1 == "Y" || $cut1 == "y" || $cut1 == "yes" ]]
		then
			echo $'\nPlease specify field number: '
			read field1
			echo $'========================================================================='
			awk $'{print $0\n}' $Path/$DBname/$TBname | cut -f$field1 -d" "
			echo $'========================================================================='
		else
			echo $'\n'
			echo $'========================================================================='
			column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
			echo $'=========================================================================\n'	
		fi
        else
		echo $'\nPlease enter a search value to select record(s): '
		read value
		echo $'\nWould you like to print a specific field? [y/n]'
		read cut
		if [[ $cut == "Y" || $cut == "y" || $cut == "yes" ]]
		then
			echo $'\nPlease specify field number: '
			read field
			echo $'========================================================================='
			awk -v pat=$value $'$0~pat{print $0\n}' $Path/$DBname/$TBname | cut -f$field -d" "
			echo $'========================================================================='
		else
			echo $'========================================================================='
			awk -v pat=$value '$0~pat{print $0}' $Path/$DBname/$TBname | column -t -s ' '
			echo $'========================================================================='	
		fi
	fi
	echo $'\nWould you like to make another query? [y/n]'
	read answer
	if [[ $answer == "Y" || $answer == "y" || $answer == "yes" ]]
	then
		clear
		./selectTB.sh
	elif [[ $answer == "N" || $answer == "n" || $answer == "no" ]]
	then	
		clear
		
	./connectDB.sh
	else
		echo "Redirecting to main menu.."
		sleep 2
		./main.sh
	fi
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [y/n]"
	read answer
	case $answer in
		y)
		./createTB.sh;;
		n)
		./selectTB.sh;;
		*)
		echo "Incorrect answer. Redirecting to main menu.." ;
		sleep 2;
		./main.sh;;
	esac
fi