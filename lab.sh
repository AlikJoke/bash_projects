#!/bin/bash

if [ $# -le 2 ];
then
	echo "Files not found"
	exit 1
fi

sudo find / -type d -name "$1" > ~/param1
sudo find / -type d -name "$2" > ~/param2

number1=$(cat ~/param1|wc -l)
number2=$(cat ~/param2|wc -l)

if [[ $number1 -gt 1 ]];
then
        echo "Number of catalogue's with the name $1 is more than 1"
        rm ~/param1
        rm ~/param2
        exit 2
fi

if [[ $number2 -gt 1 ]];
then
        echo "Number of files with the name $2 is more than 1"
        rm ~/param1
        rm ~/param2
        exit 3
fi

directOut=$(head -1 ~/param1)
directTo=$(head -1 ~/param2)

if ! [[ -s ~/param1 ]];
then
        echo "Catalogue $1 not found"
        rm ~/param1
        rm ~/param2
        exit 4
fi

if ! [[ -s ~/param2 ]];
then
        echo "File $2 not found"
        rm ~/param1
        rm ~/param2
        exit 5
fi

rm ~/param1
rm ~/param2

if ! [[ -x "$directOut" ]];
then
        echo "Unable to execute catalogue $1"
        exit 6
fi

if ! [[ -r "$directOut" ]];
then
        echo "Unable to read catalogue $1"
        exit 7
fi

if ! [[ -w "$directTo" ]];
then
        echo "Unable to write catalogue $2"
        exit 8
fi

if ! [[ -x "$directTo" ]];
then
        echo "Unable to execute catalogue $2"
        exit 9
fi

array=( $@ )

i=2

while [ $i -lt $# ];
do
	if ! [ -e $directOut/${array[$i]} ];
	then
		echo "File ${array[$i]} not found"
	fi
	i=$(($i+1))
done

i=2

while [ $i -lt $# ];
do
	if [[ -w $directOut/${array[$2]} ]];
	then
		cat $directOut/${array[$i]} >> $directTo/${array[2]}
		i=$(($i+1))
	else 
		echo  "Unable to write in file $3" 
		exit 10
	fi
done


