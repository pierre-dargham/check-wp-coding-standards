#!/bin/bash

declare -r dir="."
#declare -r standard="WordPress"
declare -r standard="WordPress-Core"
declare -r ext=".phpcs"

echo "Cleaning temp $ext files ... "
for cs in $(find $dir -name "*$ext")
do
    rm $cs
done

if [ "$1" != "--clean" ]
then
	echo ""
	echo "Parsing all .php files ... "
	echo ""
	for php in $(find $dir -name "*.php")
	do
	    phpcs="${php::-4}$ext"
	    results=$(phpcs --standard=$standard $php)
	    if [ $? != 0 ]
	    then
	    	echo "Error / Warning found : see $phpcs"
	    	echo "$results" > $phpcs
	    fi
	done
	echo ""
fi

echo "Done !"