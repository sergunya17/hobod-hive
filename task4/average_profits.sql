ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/json-serde-1.3.8-jar-with-dependencies.jar;

USE naumovse;

DROP VIEW IF EXISTS first_half;
CREATE VIEW first_half AS
SELECT content.userInn as inn, AVG(COALESCE(content.totalSum, 0)) as avg_profit
FROM kkt
WHERE HOUR(content.datetime.date)*60 + MINUTE(content.datetime.date) < 13*60
GROUP BY content.userInn;

DROP VIEW IF EXISTS second_half;
CREATE VIEW second_half AS
SELECT content.userInn as inn, AVG(COALESCE(content.totalSum, 0)) as avg_profit
FROM kkt
WHERE HOUR(content.datetime.date)*60 + MINUTE(content.datetime.date) >= 13*60
GROUP BY content.userInn;

SELECT f.inn as inn, ROUND(f.avg_profit) as first_half_avg_profit, ROUND(s.avg_profit) as second_half_avg_profit
FROM first_half f
LEFT JOIN second_half s
ON f.inn = s.inn
WHERE f.avg_profit > s.avg_profit
ORDER BY first_half_avg_profit
LIMIT 50;
