#!/bin/bash
clear
. ./ValidationsFunction.sh
echo "Please Enter Table Name To Insert Data Into : "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
	then
	           
	        x=`grep 'PK' $Path/$DBname/$TBname | wc -w`
	        
	     awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
			echo -e  >> $Path/$DBname/$TBname
	        for((i=1;i <= x;i++)) 
	        do      
	        	colName=`grep PK $Path/$DBname/$TBname | cut -f$i -d"|"`
	        	
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
					echo "Back To  Menu For Tables ..."
					. ./connectDB.sh
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