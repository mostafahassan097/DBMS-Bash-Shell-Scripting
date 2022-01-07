#!/bin/bash
echo "Please Enter Database Name :";
read DBname;

if  [[ $DBname =~ ^[a-zA-Z]+$ ]]
then
    if [ -d $Path/$DBname ]
    then 
    echo "Sorry Database is already exists";
    else
    mkdir $Path/$DBname;
    echo "$DBname Database Created Successfully";
        sleep 2;
     read -p "Do You Want Create Tables [y\n]? " c
        case "$c" in 
        y|Y ) sleep 2 ; . ./createTB.sh;;
        n|N ) sleep 2 ; . ./main.sh;;
        * ) echo "Not An Option !!";;
        esac
    fi;
else
    echo "Sorry Database Name Must Be Only Alphabet !!";
    sleep 2;
    . ./createDB.sh;
fi;