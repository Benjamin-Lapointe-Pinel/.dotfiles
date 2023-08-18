#!/usr/bin/env bash

command -v mpstat >/dev/null 2>&1 || exit $?

cpu_usage=$(mpstat 1 1 | awk 'END { print 100 - $12 }')
cpu_usage_int=$(printf "%.0f" $cpu_usage)

if [ "$cpu_usage_int" -lt 70 ]
then
  fg='white'
elif [ "$cpu_usage_int" -lt 80 ]
then
  fg='yellow'
elif [ "$cpu_usage_int" -lt 90 ]
then
  fg='color17'
else
  fg='red'
fi

printf "#[fg=$fg]cpu: %6.2f%%" $cpu_usage
