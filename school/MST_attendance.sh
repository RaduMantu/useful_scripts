#!/bin/bash

# MST_attendance.sh - Extract UTF-8 student IDs from UTF-16 MS Teams attendance
#   $1 : [required] MS Teams attendance report (will not be modified)
#   $2 : [optional] starting line - discards header (default: 9)

if [ $# -ne 1 ]; then
    printf '\033[1;31m Usage: ./MST_attendance <attendance_report>'
fi

REPORT_FILE="${1}"
START_LINE=${2:-9}

cat ${REPORT_FILE}              `# print content of report              ` \
| iconv -f UTF-16 -t UTF-8 -    `# convert from UTF-16 to UTF-8         ` \
| tail -n +${START_LINE}        `# drop report header lines             ` \
| awk '{print $NF}'             `# print only last filed (the ID)       ` \
| cut -d@ -f1                   `# split user mail and select ID        ` \
| sort                          `# sort user IDs to eliminate duplicates` \
| uniq                          `# eliminate consecutive duplicates     `

