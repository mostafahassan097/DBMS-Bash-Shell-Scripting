#!/bin/bash
echo "Please Enter Table Name To Select Date Form: "
read TBname
if [[ -f $HOME/dbms-bash/DBs/$DBname/$TBname ]]
then
	echo $'\n'
        awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
        echo $'\n Do You Want Display All Records ? [Y/N]'
        read all
        if [[ $all == "Y" || $all == "y"  ]]
        then
        	echo $'\nDo You Want Print Specific Field ?[Y/N]'
		read fld
		if [[ $fld == "Y" || $fld == "y" ]]
		then
			echo $'\nPlease Enter Field Number You Want  Select : '
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
		if [[ $cut == "Y" || $cut == "y"  ]]
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
	if [[ $answer == "Y" || $answer == "y"  ]]
	then
	 .  ./selectTB.sh
	elif [[ $answer == "N" || $answer == "n"  ]]
	then	
		clear
		
	 . ./connectDB.sh
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
		. ./createTB.sh;;
		n)
		. ./connectDB.sh;;
		*)
		echo "Incorrect answer. Redirecting to main menu.." ;
		sleep 2;
		./main.sh;;
	esac
fi