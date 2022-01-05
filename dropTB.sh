#!/bin/bash 
echo "All Tables For $DBname"
echo "======================================================="
ls $Path/$DBname
echo "======================================================="
echo "Please Enter Table Name You Want Delete:"
read TBname
if [ -f  $Path/$DBname/$TBname ]
then
    echo "Are you sure you want to delete $TBname"
    read choice
            case $choice in
            y|Y) 
                rm $Path/$DBname/$TBname
                echo "$TBname Deleted Successfully"
                echo "Recent Tables For $DBname"
                echo "======================================================="
                ls $Path/$DBname
                sleep 2
                clear 
                sleep 2
                . ./connectDB.sh
                ;;
            n|N) 
                break
                ;;
            *) echo "Choose Valid Option" ;;
            esac
            
else
    echo "$TBname Doesn't exist!"
fi
