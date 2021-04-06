ADD JAR /opt/cloudera/parcels/CDH/lib/hive/lib/json-serde-1.3.8-jar-with-dependencies.jar;

USE naumovse;

DROP VIEW IF EXISTS profits;
CREATE VIEW profits AS
SELECT content.userInn as inn, DAY(content.datetime.date) as day, COALESCE(SUM(content.totalSum), 0) as profit
FROM kkt
WHERE content.userInn IS NOT NULL
GROUP BY content.userInn, DAY(content.datetime.date);

DROP VIEW IF EXISTS best_days;
CREATE VIEW best_days AS
SELECT *, ROW_NUMBER() OVER (PARTITION BY inn ORDER BY profit DESC) row_num
FROM profits;

SELECT inn, day, profit
FROM best_days
WHERE row_num = 1
ORDER BY inn;

