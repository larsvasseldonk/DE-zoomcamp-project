#SEASON_START=$1
#SEASON_END=$2

URL_PREFIX="https://www.football-data.co.uk/mmz4281"
URL_SUFFIX="E0.csv"

for YEAR in {2000..2024}; do
  NEXT_YEAR=$(($YEAR + 1))
  SEASON=${YEAR: -2}${NEXT_YEAR: -2}   
  URL="${URL_PREFIX}/${SEASON}/${URL_SUFFIX}"
  
  FILE_PATH="premierleague_${SEASON}.csv"

  echo "downloading ${URL} to ${FILE_PATH}"
  wget ${URL} -O ${FILE_PATH}

done