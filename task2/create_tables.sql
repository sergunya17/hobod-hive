ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/json-serde-1.3.8-jar-with-dependencies.jar;

USE naumovse;

DROP TABLE IF EXISTS kkt_textfile;
CREATE TABLE kkt_textfile
STORED AS TEXTFILE
AS SELECT * FROM kkt;

DROP TABLE IF EXISTS kkt_orc;
CREATE TABLE kkt_orc
STORED AS ORC
AS SELECT * FROM kkt;

DROP TABLE IF EXISTS kkt_parquet;
CREATE TABLE kkt_parquet
STORED AS PARQUET
AS SELECT * FROM kkt;

