USE naumovse;

SELECT content.userinn as userinn, SUM(content.totalsum) as profit
FROM kkt_parquet
WHERE subtype = 'receipt'
GROUP BY content.userinn
ORDER BY profit DESC
LIMIT 1;

