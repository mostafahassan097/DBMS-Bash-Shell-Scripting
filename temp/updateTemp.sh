#!/bin/bash
echo "Please enter table name to update data: "
read $TBname
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
		echo "Please enter old value: "
		read old
		echo ""
		if grep "${old}" $Path/$DBname/$TBname  >> /dev/null
		then
			echo "Please enter new value: "
			read new
			checkType $fieldnum $new
			if [[ $? != 0 ]]
				then
					echo "Incorrect data type entry. Redirecting.."
					sleep 2
					. ./updateTB.sh
				else	
					 awk -v oldval=$old -v newval=$new -v colnum=$fieldnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $Path/$DBname/$TBname
					echo $'Record(s) updated successfully!'
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

















    #!/bin/bash
. ./ValidationsFunction.sh
echo "Please Enter Table Name To Update Data: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
	echo $'\n'
	echo "Please Enter Number Of Field You Want Update: "
	read fnum
	totalFields=`awk '{print NF}' $Path/$DBname/$TBname | head -1`
	if [[ $fnum -gt $totalFields || $fnum -lt 1 ]]
	then
		echo "Incorrect field number. Redirecting.."
		sleep 2
		. ./updateTB.sh
	else
					 echo "\n $TBname Before Update"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	        
		echo "Please Enter Old Value You Want Update ?"
		read old
		echo ""
		if grep "${old}" $Path/$DBname/$TBname >> /dev/null
		then
			echo "Please Enter New Value : "
			read new
			checkDataType $fnum $new
			if [[ $? != 0 ]]
				then
					echo "Incorrect data type entry. Redirecting.."
					sleep 2
					. ./updateTB.sh
				else	
					 awk -v oldval=$old -v newval=$new -v colnum=$fnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $Path/$DBname/$TBname
					echo $'Record(s) updated successfully!'
					echo $'\n'
					echo "$TBname After Updated"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	

					echo "Do You Want To Update More Records ? [y/n]"
					read ans
					case $ans in
						y)
						. ./updateTB.sh;;
						n) echo "Back To Table Menu"
						. ./connectDB.sh;;
						*)
						echo "Not An Option Back To Main .. " ;
						sleep 2;

						. ./main.sh;;
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
		echo "Back To Main Menu.." ;
		sleep 2;
		. ./main.sh;;			
	esac
	fi
