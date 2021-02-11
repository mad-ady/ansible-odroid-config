#!/bin/bash

echo "# HELP number_of_lines_in_log The number of lines in the log files"
echo "# TYPE number_of_lines_in_log counter"


for file in auth.log dmesg kern.log syslog messages; 
do
        if [ -f "/var/log/$file" ]; then
                lines=`wc -l /var/log/$file | cut -d " " -f 1`
                echo "number_of_lines_in_log{file=\"$file\"} $lines"
        fi
done