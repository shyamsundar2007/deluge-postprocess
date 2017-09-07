#!/bin/sh
export PATH=$HOME/bin

# Input Parameters
HOME_PATH="/media/sdc1/shyam2007"
PLEX_MOVIE_PATH="${HOME_PATH}/private/Movies/"
PLEX_TV_PATH="${HOME_PATH}/private/TV Shows/"
PLEX_MUSIC_PATH="${HOME_PATH}/private/Music/"
DELUGE_PATH="${HOME_PATH}/private/deluge"
DELUGE_MOVIE_PATH="${DELUGE_PATH}/movies"
DELUGE_TV_PATH="${DELUGE_PATH}/tv_shows"
DELUGE_MUSIC_PATH="${DELUGE_PATH}/music"

ARG_NAME="movie"
ARG_PATH="/media/sdc1/shyam2007/private/deluge/movies/"
ARG_LABEL="N/A"

echo "$ARG_PATH" >> logfile.log
echo "$ARG_NAME" >> logfile.log

# Configuration
CONFIG_OUTPUT="${HOME_PATH}/private" # if this script is called by the deluge user, then $HOME will NOT refer to YOUR user home, but paths such as /var/lib/deluge instead

# fetch new movies
$HOME/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict auto -non-strict --log-file amc.log --def unsorted=y music=n artwork=y excludeList=".excludes" ut_dir="${DELUGE_MOVIE_PATH}" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"

# fetch new tv shows
$HOME/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict auto -non-strict --log-file amc.log --def unsorted=y music=n artwork=y excludeList=".excludes" ut_dir="${DELUGE_TV_PATH}" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"

# fetch new music
$HOME/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict auto -non-strict --log-file amc.log --def unsorted=y music=y artwork=y excludeList=".excludes" ut_dir="${DELUGE_MUSIC_PATH}" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL"

# fetch subtitles for movies and TV shows
$HOME/filebot/filebot.sh -script fn:suball $CONFIG_OUTPUT --def maxAgeDays=10

echo " " >> logfile.log
