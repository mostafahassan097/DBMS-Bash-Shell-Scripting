#!/bin/bash
function DeleteRecord(){
	echo "Please Enter Field Number To Find Value: "
	read field
	num='^[0-9]+$'
	x=`grep 'PK' $Path/$DBname/$TBname | wc -w`
if [[ $field =~ $num ]] && [ $field -le $x  ]
then 
	echo $'\n'
	echo "$TBname Before Delete"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	echo "Please Enter Field Value To Delete Record(s): "
	read value
	echo $'\n'
	exist=`grep -E "$value" $Path/$DBname/$TBname | wc -l `
	if ! [ exist -eq 0]
	#if cut -f$field -d" " $Path/$DBname/$TBname | grep -w -q ${value}
	then
		sed -i "/$value/d" $Path/$DBname/$TBname
		echo $'Record(s) deleted successfully!\n'
		            echo "$TBname After Delete"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	else
		echo $'No such entry in that column!\n'
		./deleteTB.sh
	fi
else echo "Field number shloud be integer value and less than number of feilds "
     . ./deleteTB.sh
fi 
}

function DeleteAllRecords(){
	echo "$TBname Before Delete"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	
	
		sed -i '2,$ d' $Path/$DBname/$TBname
	echo $'Record(s) deleted successfully!\n'
		            echo "$TBname After Delete"
					echo $'========================================================================='
					column -t -s ' '   $Path/$DBname/$TBname 2> /dev/null
					echo $'=========================================================================\n'	

}
echo "Please Enter Table Name To Delete From: "
read TBname
if [[ -f $Path/$DBname/$TBname ]]
then
	echo $'\n'
	awk '{if (NR==1) {for(i=1;i<=NF;i++){printf "    |    "$i}{print "    |"}}}' $Path/$DBname/$TBname
	echo $'\n'
	
	select opt in "Delete specific Record" "Delete all Records"
		do
			case $REPLY in 
				1) DeleteRecord 
				   sleep 2
				   clear 
				   sleep 2
				   . ./connectDB.sh
				   ;;
				2)  DeleteAllRecords
				 sleep 2
				   clear 
				   sleep 2
				   . ./connectDB.sh
				   ;;
				*) echo "Not an Option !!" 
				sleep 2
				   clear 
				   sleep 2
				   . ./deletTB.sh
				   ;;
			esac
		done
	#----------------------------------------------------
    #----------------------------------------------------------------------------------------

else
	echo "Table doesn't exist"
	echo "Do you want to create it? [Y/N]"
	read answer
	case $answer in
		Y)
		 . ./createTB.sh ;;
		N)
		. ./deleteTB.sh ;;
		*)
		echo "Not an Option Back to main menu.." ;
		sleep 2;
		./main.sh;;			
	esac
	fi