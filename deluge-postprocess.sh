#!/bin/sh

# Input Parameters
ARG_NAME="$2"
ARG_PATH="$3"
ARG_LABEL="N/A"
REGEX="^.*(movies|shows|music).*$"
REGEX_BOOKS="^.*books.*$"

echo "$ARG_PATH" >> logfile.log
echo "$ARG_NAME" >> logfile.log

# Configuration
CONFIG_OUTPUT="/media/sdl1/home/shyam2007/private" # if this script is called by the deluge user, then $HOME will NOT refer to YOUR user home, but paths such as /var/lib/deluge instead

if [[ $ARG_PATH =~ $REGEX ]]; then
	echo "Match." >> logfile.log
	~/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict skip -non-strict --log-file amc.log --def unsorted=y music=y artwork=y excludeList=".excludes" ut_dir="$ARG_PATH" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL" --def pushbullet=o.6fVF9BUU2t0XKoT43NJa3Ldykewv31JJ
	~/filebot/filebot.sh -script fn:suball $CONFIG_OUTPUT 

elif [[ $ARG_PATH =~ $REGEX_BOOKS ]]; then
	echo "Book match." >> logfile.log

	# connect via scp
	scp -r -i ~/.ssh/digital_ocean "$ARG_PATH/$ARG_NAME" root@139.59.42.233:calibre-library/toadd/
else
	echo "No match." >> logfile.log
fi

echo " " >> logfile.log
