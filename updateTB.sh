#!/bin/bash
echo "Please Enter Table Name To Update Data: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++)}}' $TBname;
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
		echo "Please Enter Old Value You Want Update "
		read old
		echo ""
		if grep "${old}" $table >> /dev/null
		then
			echo "Please Enter New Value : "
			read new

			checkType $fnum $new
			if [[ $? != 0 ]]
				then
					echo "Incorrect data type entry. Redirecting.."
					sleep 2
					. ./updateTB.sh
				else	
					 gawk -v oldval=$old -v newval=$new -v colnum=$fnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $Path/$DBname/$TBname
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
		echo "Back To Main Menu.." ;
		sleep 2;
		. ./main.sh;;			
	esac
	fi
