#!/bin/bash

# Find the base directory name instead of a full path.
dirname=${PWD##*/}

if [ "$dirname" != ".backup" ]; then
    echo "ERROR: Run this script from the .backup directory."
    exit
fi

echo "Cleaning up the ${dirname} directory..."

mkdir -p .trash

prev_file=""
prev_file_op=""

count=`ls | wc -l`
i=1

for file in `ls`
do
    echo -n -e "\rChecking $i/$count"
    ((i++))

    file_op=`echo $file | head -c 14 | tail -c 1`
    diff=`diff $prev_file $file 2>&1`

    if [ "$diff" == "" ]; then
        if [ "$prev_file_op" == "$file_op" ]; then
            # File opened or written multiple times without any changes. Keep
            # the latest revision and remove older revisions.

            echo "Removing duplicate" $prev_file
            mv $prev_file .trash/

        elif [ "$file_op"  == "w" ]; then
            # File written without any changes after opening. Remove the
            # duplicate write revision.

            echo "Removing duplicate" $file
            mv $file .trash/

            continue
        fi
    fi

    prev_file=$file
    prev_file_op=$file_op
done

echo -e "\nDone."
