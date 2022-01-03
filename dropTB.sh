#!/bin/bash 

echo "Please Enter Table Name You Want Delete:"

if [ -f  $Path/$DBname/$TBname ]
then
    echo "Are you sure you want to delete $TBname"
    select choice in 'y' 'n'
        do 
            case $choice in
            'y') 
                rm $Path/$DBname/$TBname
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


