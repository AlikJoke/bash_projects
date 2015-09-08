#!/bin/bash

if

   [ $# -ne 3 ]

then

   echo "Invalid number of parameters!"

   exit 1

fi



if

   expr "$3" : '[0-9][0-9]*$'>/dev/null

then

   :

else

   echo "The third parameter must be a number!"

   exit 2

fi



sudo find / -name $1 > ~/directories



if

   [ -s ~/directories ]

then

   path=$(head -1 ~/directories)

   rm ~/directories

else

   echo "The input directory is not exist!"

   rm ~/directories

   exit 3

fi



if

   [ ! -w $path ]

then

   echo "The input directory doesn't have write permission!"

   exit 4

elif

   [ ! -x $path ]

then

   echo "The input directory doesn't have execute permission!"

   exit 5

fi



currentDirectory=$(pwd)



if

   [ ! -w $currentDirectory ]

then

   echo "Your current directory doesn't have write permission!"

   exit 6

elif

   [ ! -r $currentDirectory ]

then

   echo "Your current directory doesn't have read permission!"

   exit 7

fi



for FILE in $path/*.$3*; do

   if

      [ ! -w $FILE ]

   then

      echo "Some of files in your input directory don't have write permission!"

      exit 8

   elif

      [ ! -r $FILE ]

   then

      echo "Some of files in your input directory don't have read permission!"

      exit 9

   else

      cp $path/*.$3* .

   fi

done



if

   [ -e ~/$2 ]

then

   :

else

   cat * > ~/$2

fi
