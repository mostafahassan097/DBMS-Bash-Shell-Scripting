#!/bin/bash


echo "Please enter table name to insert data: "
read TBname
if [[ -f  $Path/$DBname/$TBname ]]
	then
	           
	        x=`grep 'PK'  $Path/$DBname/$TBname | wc -w`
	        
	        awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}'  $Path/$DBname/$TBname
	        for((i=1;i <= x;i++)) 
	        do      
	        	columnName=`grep PK  $Path/$DBname/$TBname | cut -f$i -d" "`
	        	echo $'\n'
	        	echo $"Please enter data for field no.$i [$columnName]"
	        	read data 
			checkType $i $data
	        	if [[ $? != 0 ]]
	        	then
	        		(( i = $i - 1 ))
	        	else	
	        		echo -n $data" " >>  $Path/$DBname/$TBname
			fi
	        done	
	        echo $'\n' >>  $Path/$DBname/$TBname
		echo "insert done into $table"
	else
		echo "Table doesn't exist"
		echo "Do you want to create it? [y/n]"
		read answer
		case $answer in
			y)
			./createTB.sh;;
			n)
			./insertTB.sh;;
			*)
			echo "Incorrect answer. Redirecting to main menu.." ;
			sleep 2;
	
			./main.sh;;	
		esac
        
	fi


