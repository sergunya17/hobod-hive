#! /usr/bin/env bash

SECONDS=0
hive -f kkt_textfile.sql
textfile_time=$SECONDS

SECONDS=0
hive -f kkt_orc.sql
orc_time=$SECONDS

SECONDS=0
hive -f kkt_parquet.sql
parquet_time=$SECONDS

echo "Data storage format | Query time, sec" > results.md
echo ":---: | :---:" >> results.md
echo "Textfile | $textfile_time" >> results.md
echo "ORC | $orc_time" >> results.md
echo "Parquet | $parquet_time" >> results.md

