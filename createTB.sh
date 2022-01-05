#!/bin/bash
clear

echo "Please Enter Table Name :";
read TBname;
if  [[ $TBname =~ ^[a-zA-Z]+$ ]]
then
    if [ -f $Path/$DBname/$TBname ]
    then 
    echo "Sorry Table Name is Already Exists";
    sleep 2;
    . ./createTB.sh;
    else
    touch $Path/$DBname/$TBname;
    echo "Table Created Successfully";
            sleep 2;
        echo "Please Enter Number Of Columns:";
        read num;
        if [[ $num =~ ^[0-9]+$ ]]
        then
            flag=0;
                for((i=1 ; i<=$num ; i++))
                do
                    echo "Enter Name Of Column No.$i";
                    read colname;
                    while [ $flag -eq 0 ]
                    do
                        echo "Do you Want This Column To Be PRIMARY KEY(y/n)?";
                        read pk;
                        if [[ $pk == "Y" || $pk == "y" ]]
                        then
                            flag=1;
                            echo -n "#PK:" >> $Path/$DBname/$TBname;
                        else
                            break;
                        fi
                    done
                    echo "Please Choose Datatype For Column {int | string} ?"
                       read dataType;
                            case $dataType in 
                                "int") 
                                echo -n $colname":$dataType: " >> $Path/$DBname/$TBname ;;
                                "string")  
                                echo -n $colname":$dataType: " >> $Path/$DBname/$TBname ;;
                                *) 
                                echo "Not an Option !!";
                                ((i = $i - 1));;
                            esac
                done
                echo "Your Table Create Successfully ";
                sleep 2;
                clear;
                . ./connectDB.sh;
        else
            echo "Sorry You Must Enter Number For Columns !!";
                sleep 2;
                . ./createTB.sh;
        fi;
    fi;
else
    echo "Sorry Table Name Must Be Only Alphabet!!";
    sleep 2;
    . ./connectTB.sh;
fi;