#!/bin/bash

if [ $# -lt 3 ];
then
	echo "Invalid number of parameters"
	exit 1
fi
sudo find / -type d -name $1 > $dir1
sudo find / -type d -name $2 > $dir2

if [ $dir1 -eq "" ];
then
	echo "The directory $1 doesn't exist"
	exit 2
fi

if [ $dir2 -eq "" ];
then
	echo "The directory $2 doesn't exist"
	exit 3
fi

if ! [[ -r $dir1 && -x $dir1 ]];
then
	echo "The directory $1 doesn't have read and execute permissions"
	exit 4
fi

if ! [[ -w $dir2 && -x $dir2 ]];
then
	echo "The directory $2 doesn't have write and execute permissions"
	exit 5
fi

declare -a array
array=( $@ )

i=2
while [ $i -lt $# ]
do
       
	if ! [ -e $dir1/*.${array[$i]} ];
	then
	       echo "Files with the specified extension doesn't exist"
	fi

	if ! [ -w $dir1/*.${array[$i]} ];
	then
	      echo "Some file ${array[$i]} in your input directory din't have write permission"
	fi

	if ! [ -r $dir1/*.${array[$i]} ];
	then
	      echo "Some file ${array[$i]} in your input directory din't have read permission"
	fi
i=$(($i+1))
done

i=2
while [ $i -lt $# ]
do
cp $dir1/*.${array[$i]} $dir2
i=$(($i+1))
done
done
