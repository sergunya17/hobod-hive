ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/json-serde-1.3.8-jar-with-dependencies.jar;

USE naumovse;

DROP TABLE IF EXISTS kkt;

CREATE external TABLE kkt (
    id Struct < oid: String >,
    kktRegId String,
    subtype String,
    content Struct < userInn: String, totalSum: Bigint, dateTime: struct < date: Timestamp > >
)
ROW FORMAT SERDE 'org.openx.data.jsonserde.JsonSerDe'
WITH SERDEPROPERTIES (
    'ignore.malformed.json' = 'true',
    'mapping.id' = '_id',
    'mapping.oid' = '$oid',
    'mapping.date' = '$date'
)
STORED AS TEXTFILE
LOCATION '/data/hive/fns2';

SELECT * FROM kkt LIMIT 50;
