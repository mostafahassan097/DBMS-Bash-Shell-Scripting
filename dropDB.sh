#!/bin/bash
echo "Please Enter Database Name :";
read DBname;
if  [[ $DBname =~ ^[a-zA-Z]+$ ]]
then
    if [ -d ./DBs/$DBname ]
    then 
    read -p "Are You Sure You Want Delete $Dbname (y/n)?" c
        case "$c" in 
        y|Y ) rm -r ./DBs/$DBname; echo "Deleted Successfully" ; sleep 2 ; . ./main.sh;;
        n|N ) echo "no" sleep 2 ; . ./main.sh;;
        * ) echo "invalid";;
        esac
    else
    echo "Sorry This Database Name doesn't exists";
    . ./dropDB.sh;
    fi;
else
    echo "Sorry Database Name Must Be Only Alphabet !!";
    sleep 2;
    . ./main.sh;
fi;