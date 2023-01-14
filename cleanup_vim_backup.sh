#!/bin/bash

prev_file=""
prev_file_op=""

for file in `ls .backup`
do
    file_op=`echo $file | head -c 14 | tail -c 1`
    diff=`diff .backup/$prev_file .backup/$file 2>&1`

    if [ "$diff" == "" ]; then
        if [ "$prev_file_op" == "$file_op" ]; then
            # File opened or written multiple times without any changes. Keep
            # the latest revision and remove older revisions.

            # echo "removing duplicate" $prev_file
            rm .backup/$prev_file

        elif [ "$file_op"  == "w" ]; then
            # File written without any changes after opening. Remove the
            # duplicate write revision.

            # echo "removing duplicate" $file
            rm .backup/$file

            continue
        fi
    fi

    prev_file=$file
    prev_file_op=$file_op
done
