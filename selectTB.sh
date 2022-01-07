#!/bin/bash
function AllRecords(){
            echo $'\n'
			echo $'========================================================================='
			column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
			echo $'=========================================================================\n'	
	        
}
function SpecificRecord(){
			echo $'\nPlease enter a search value to select record(s): '
			read value
			echo $'========================================================================='
			#awk -v pat=$value '$0~pat{print $0}' $Path/$DBname/$TBname | cat 
			awk "/$value/" $Path/$DBname/$TBname | cat 
			echo $'========================================================================='
}
function AllRecordsSpecificField(){
	        echo $'\nPlease Enter Field Number You Want  Select : '
			read field1
			echo $'========================================================================='
			awk $'{print $0\n}' $Path/$DBname/$TBname | cut -f$field1 -d" "
			echo $'========================================================================='

}
function Query(){
	select opt in "All Records" "Specific Record" "All Records Specific Field"
		do
			case $REPLY in 
				1) AllRecords 
				   break  ;;
				2) SpecificRecord
				   break ;;
				3) AllRecordsSpecificField
				   break  ;;
				*) echo "Not an Option !!" ;;
		    esac
	done
	
}

		echo "Please Enter Table Name To Select Date Form: "
		read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
        awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
		#-------------------------------------------------------------
		Query 
	    #-----------------------------------------------------------------------------------------
	while true
	do
		select opt in "another Query on the same Table" "another Query on onther Table" "Back To Tables Menu"
		do
			case $REPLY in 
				1) Query
				   ;;
				2)ls $Path/$DBname  
				   . ./selectTB.sh
				   break  ;;
				3) . ./connectDB.sh
				   break;;
				*) echo "Not an Option !!" ;;
			esac
		done
	done
		#------------------------------------------------------------------------------------------
	
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