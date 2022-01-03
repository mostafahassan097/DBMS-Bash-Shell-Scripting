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
    select choice in 'y' 'n'
        do 
            case $choice in
            'y') 
                rm $Path/$DBname/$TBname
                echo "$TBname Deleted Successfully"
                echo "Recent Tables For $DBname"
                echo "======================================================="
                ls $Path/$DBname
                break
                ;;
            'n') 
                break
                ;;
            *) echo "Choose Valid Option" ;;
            esac
            done
else
    echo "$TBname Doesn't exist!"
fi
