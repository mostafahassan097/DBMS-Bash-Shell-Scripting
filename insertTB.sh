#!/bin/bash
clear
. ./ValidationsFunction.sh
echo "Please Enter Table Name To Insert Data Into : "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
	then
	           
	        x=`grep 'PK' $Path/$DBname/$TBname | wc -w`
	        
			column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
			echo -e  >> $Path/$DBname/$TBname
	        for((i=1;i <= x;i++)) 
	        do      
	        	colName=`grep PK $Path/$DBname/$TBname | cut -f$i -d" "`
	        	
	        	echo $"Please  Enter Data For Column NO.$i [$colName]"
	        	read data 
			checkDataType $i $data
	        	if [[ $? != 0 ]]
	        	then
	        		(( i = $i - 1 ))
	        	else	
	        		echo -n $data" " >> $Path/$DBname/$TBname
					
			fi
	        done	
		echo "Insert Done To $TBname"
					sleep 1
					echo "Do You Want To Insert More Records ? [y/n]"
					read ans
					case $ans in
						y)
						. ./insertTB.sh;;
						n) echo "Back To Table Menu"
						. ./connectDB.sh;;
						*)
						echo "Not An Option Back To Main .. " ;
						sleep 2;

						. ./main.sh;;
						esac	
	else
		echo "Table Doesn't Exist"
		echo "Do You Want To Create it? [y/n]"
		read ans
		case $ans in
			y)
			. ./createTB.sh;;
			n)
			. ./insertTB.sh;;
			*)
			echo "Not An Option Back To Main .. " ;
			sleep 2;
		
			. ./main.sh;;	
		esac
        
	fi