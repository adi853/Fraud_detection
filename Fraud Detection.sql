-- Creating database --
Create database fraud_detection;
Use fraud_detection;
SELECT 
    *
FROM
    data;

-- 1.country wise fraud --
SELECT 
    `Country`, COUNT(*) AS total_fraud
FROM
    data
WHERE
    fraud = 1
GROUP BY `Country`
ORDER BY total_fraud DESC;

-- 2. Hourly Trend --
SELECT 
    `Country`, `Hour`
FROM
    data
WHERE
    `Fraud` = 1
GROUP BY `Hour` , `Country`
ORDER BY `hour`;

-- 3.RISK SCORE CHECK --
SELECT 
    `Fraud`, COUNT(*)
FROM
    data
WHERE
    `Device_risK_score` > 0.8
GROUP BY `Fraud`;

-- 4. High Value Fraud detection --
SELECT 
    `Fraud`,
    AVG(`Amount`) AS Avg_Amount,
    MAX(`Amount`) AS Max_Amount,
    MIN(`Amount`) AS Min_Amount,
    STDDEV(`Amount`) AS volatility
FROM
    data
GROUP BY `Fraud`;

-- 5. running total of loss --
Select `Hour`,`Amount`,
round(Sum(`Amount`) Over(order by `Hour`),2) as running_total_loss_of_data
from data
where `Fraud`=1;

-- 6. Amount "Bucketing" --
SELECT 
    CASE
        WHEN Amount > 5000 THEN 'low amount'
        WHEN Amount BETWEEN 5000 AND 10000 THEN 'Medium amount'
        ELSE 'high value'
    END AS Amount_category
FROM
    data
WHERE
    Fraud = 1
GROUP BY 1;
