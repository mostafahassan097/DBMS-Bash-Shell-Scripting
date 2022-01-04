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

	#--------------------------------------------------------------------------------------------
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