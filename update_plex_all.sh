#!/bin/sh
export PATH=$HOME/bin/jdk-15.0.1/bin:$PATH

start=$(date +%s)

# Input Parameters
HOME_PATH="/home/shyamsundar2007"
PLEX_MOVIE_PATH="${HOME_PATH}/files/Movies/"
PLEX_TV_PATH="${HOME_PATH}/files/TV Shows/"
LOG_PATH="${HOME_PATH}/log/update_plex_assets_log.log"

DELUGE_PATH="${HOME_PATH}/downloads"
DELUGE_MOVIE_PATH="${DELUGE_PATH}/movies/movies_completed"
DELUGE_TV_PATH="${DELUGE_PATH}/tv_shows/tv_shows_completed"

# Add timestamp to log
echo "$(date +'%Y-%m-%d %H:%M:%S')" >> "$LOG_PATH"

ARG_NAME="movie"
ARG_PATH="${HOME_PATH}/files/movies/"
ARG_LABEL="N/A"

echo "$ARG_PATH" >> "${LOG_PATH}"
echo "$ARG_NAME" >> "${LOG_PATH}"

# Configuration
CONFIG_OUTPUT="${HOME_PATH}/files" # if this script is called by the deluge user, then $HOME will NOT refer to YOUR user home, but paths such as /var/lib/deluge instead

echo "${CONFIG_OUTPUT}" >> "${LOG_PATH}"

# fetch new movies
$HOME/bin/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict auto -non-strict --log-file amc_movies.log --def unsorted=y music=n artwork=y excludeList=".excludes_movies" ut_dir="${DELUGE_MOVIE_PATH}" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL" --log warning >> "${LOG_PATH}" 2>&1

# fetch new tv shows
$HOME/bin/filebot/filebot.sh -script fn:amc --output "$CONFIG_OUTPUT" --action hardlink --conflict auto -non-strict --log-file amc_tv_shows.log --def unsorted=y music=n artwork=y excludeList=".excludes_tv_shows" ut_dir="${DELUGE_TV_PATH}" ut_kind="multi" ut_title="$ARG_NAME" ut_label="$ARG_LABEL" --log warning >> "${LOG_PATH}" 2>&1


# fetch subtitles for movies and TV shows
$HOME/bin/filebot/filebot.sh -script fn:suball "${CONFIG_OUTPUT}/Movies" --def maxAgeDays=10 --log warning >> "${LOG_PATH}" 2>&1
$HOME/bin/filebot/filebot.sh -script fn:suball "${CONFIG_OUTPUT}/TV Shows" --def maxAgeDays=10 --log warning >> "${LOG_PATH}" 2>&1

end=$(date +%s)
echo "Time taken: $(($end - $start)) seconds" >> "${LOG_PATH}"
echo " " >> "${LOG_PATH}"
