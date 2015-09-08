for var in "$@"; do

if [[ $var -ne $1 && $var -ne $2 ]]; 

then

       for FILE in $dir1/*.$var; do

	if [! -s $FILE];

	then

	       echo "Files with the specified extension doesn't exist"

	elif [! -w $FILE];

	then

	      echo "Some of files in your input directory din't have write permission"

	      exit 5

	elif [! -r $FILE];

	then

	      echo "Some of files in your input directory din't have read permission"

	      exit 6

	else

	      cp $dir1/*.$var $dir2/

	fi

       done

fi

done          


