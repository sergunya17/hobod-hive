ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/json-serde-1.3.8-jar-with-dependencies.jar;
ADD FILE ./script.py;

USE naumovse;

DROP VIEW IF EXISTS transactions;
CREATE VIEW transactions AS
SELECT content.userInn as userInn, kktRegId, UNIX_TIMESTAMP(content.datetime.date) as time, subtype
FROM kkt
WHERE content.userInn IS NOT NULL
ORDER BY userInn, kktRegId, time, subtype;

SELECT TRANSFORM(userInn, kktRegId, time, subtype)
USING './script.py' AS (userInn String)
FROM (SELECT * FROM transactions CLUSTER BY userInn) as tmp_table
LIMIT 50;

