#!/bin/bash
echo "Please enter table name to update data: "
read TBname
if [[ -f $TBname ]]
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
		./updateTB.sh
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
					./updateTB.sh
				else	
					 gawk -v oldval=$old -v newval=$new -v colnum=$fnum -i inplace '{ gsub(oldval, newval, $colnum) }; { print }' $Path/$DBname/$TBname
					echo $'Record(s) updated successfully!'
				fi
		else
			echo $'No such value in the table!'
			./updateTB.sh
		fi
	fi
else
	echo "Table doesn't exist"
	echo "Do you want to create it? [Y/N]"
	read answer
	case $answer in
		Y)
		./createTB.sh;;
		N)
		./updateTB.sh;;
		*)
		echo "Incorrect answer. Redirecting to main menu.." ;
		sleep 2;
		./main.sh;;			
	esac
	fi


function checkType {
datatype=`grep PK $Path/$DBname/$TBname | cut -f$1 -d"|"`
if [[ "$datatype" == *"int"* ]]
then
	num='^[0-9]+$'
	if ! [[ $2 =~ $num ]]
	then
		echo "False input: Not a number!"
		return 1
	else
		checkPK $1 $2
	fi
elif [[ "$datatype" == *"string"* ]]
then
	str='^[a-zA-Z]+$'
	if ! [[ $2 =~ $str ]]
	then
		echo "False input: Not a valid string!"
		return 1
	else
		checkPK $1 $2
	fi
fi
}
function checkPK {
header=`grep PK $Path/$DBname/$TBname | cut -f$1 -d"|"`
if [[ "$header" == *"PK"* ]]; then if [[ `cut -f$1 -d"|" $Path/$DBname/$TBname | grep -w $2` ]]
then
	echo $'\nPrimary Key already exists. no duplicates allowed!' 
	return 1
fi
fi
}