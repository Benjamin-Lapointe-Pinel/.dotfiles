#!/bin/sh

df -h -P -l / | awk '/\/.*/ {
	use=$5
	gsub(/%$/,"",use)
  percent=100*$3/$2

	if (percent >= 90) {
    fg="red"
	} else if (percent >= 80) {
    fg="color16"
  } else if (percent >= 70) {
    fg="yellow"
	} else {
    fg="white"
  }

  printf "#[fg=%s]disk: %3i GB / %3i GB (%3i%%)", fg, $3, $2, percent

	exit 0  # no need to continue parsing
}'
