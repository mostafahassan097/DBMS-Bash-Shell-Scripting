#!/bin/bash
. ./ValidationsFunction.sh
echo "Please enter table name to update data: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
	echo $'\n'
	echo "Please enter field number to update: "
	read fieldnum
	fields=`awk '{print NF}' $Path/$DBname/$TBname | head -1`
	if [[ $fieldnum -gt $fields || $fieldnum -lt 1 ]]
	then
		echo "Incorrect field number. Redirecting.."
		sleep 2
		 . ./updateTB.sh
	else
			echo $'\n'
		 echo "$TBname Before Update"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
		echo "Please enter old value: "
		read old
		echo ""
		if grep "${old}" $Path/$DBname/$TBname  >> /dev/null
		then
			echo "Please enter new value: "
			read new
			checkDataType $fieldnum $new
			if [[ $? != 0 ]]
				then
					echo "Incorrect data type entry. Redirecting.."
					sleep 2
					. ./updateTB.sh
				else	
					 awk -v oldval=$old -v newval=$new -v colnum=$fieldnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $Path/$DBname/$TBname
					echo $'Record(s) updated successfully!'

					echo $'\n'
					echo "$TBname After Updated"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
                        echo "Do you want tp update more records ? [Y/N]"
						read answer
						case $answer in
							Y|y)
							sleep 1;
							. ./updateTB.sh;;
							
							N|n)
							sleep 1;
							. ./connectDB.sh;;
							*) sleep 1; 
							echo "Not Valid Option " 
										
						esac
				fi
		else
			echo $'No such value in the table!'
			. ./updateTB.sh
		fi
	fi
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [Y/N]"
	read answer
	case $answer in
		Y)
		  . ./createTB.sh;;
		N)
		. ./updateTB.sh;;
		*)
		echo "Incorrect answer. Redirecting to main menu.." ;
		sleep 2;
		
	. ./main.sh;;			
	esac
	fi

