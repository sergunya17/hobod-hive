USE naumovse;

SELECT content.userinn as userinn, SUM(content.totalsum) as profit
FROM kkt_orc
WHERE subtype = 'receipt'
GROUP BY content.userinn
ORDER BY profit DESC
LIMIT 1;

