------------------------------------
-- Fraud Rate KPI
------------------------------------
SELECT
    COUNT(*) AS total_transactions,
    SUM(CAST(is_chargeback AS INT)) AS fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*), 2) 
        AS DECIMAL(10,2)) AS fraud_rate_percent
FROM transactions;


------------------------------------
-- Fraud Rate by Country
------------------------------------
SELECT
    COALESCE(ip_country, 'Unknown') AS country,
    COUNT(*) AS total_transactions,
    SUM(CAST(is_chargeback AS INT)) AS fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*), 2) 
        AS DECIMAL(10,2))  AS fraud_rate
FROM transactions
GROUP BY COALESCE(ip_country, 'Unknown')
ORDER BY fraud_rate DESC;


------------------------------------
-- Fraud Rate by Payment Method
------------------------------------
SELECT
    payment_method,
    COUNT(*) total_transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*),2)
        AS DECIMAL(5,2)) fraud_rate
FROM transactions
GROUP BY payment_method
ORDER BY fraud_rate DESC;


------------------------------------
-- Fraud Rate by Merchant Category
------------------------------------
SELECT
    COALESCE(merchant_category, 'Unknown') AS merchant_category,
    COUNT(*) total_transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*),2)
        AS DECIMAL(5,2)) fraud_rate
FROM transactions
GROUP BY merchant_category
ORDER BY fraud_rate DESC;


------------------------------------
-- Fraud Rate by Device
------------------------------------
SELECT
    COALESCE(device_type, 'Unknown') AS device_type,
    COUNT(*) transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_cases,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*),2)
        AS DECIMAL(5,2)) fraud_rate
FROM transactions
GROUP BY device_type
ORDER BY fraud_rate DESC;


------------------------------------
-- Velocity Detection
------------------------------------
WITH velocity_check AS (
    SELECT t1.user_id, t1.transaction_time,
           COUNT(*) AS transactions_in_10min
    FROM transactions t1
    JOIN transactions t2
        ON t1.user_id = t2.user_id
        AND t2.transaction_time
            BETWEEN DATEADD(MINUTE,-10,t1.transaction_time)
            AND t1.transaction_time
    GROUP BY t1.user_id, t1.transaction_time
)
SELECT *
FROM velocity_check
WHERE transactions_in_10min >= 5
ORDER BY transactions_in_10min DESC;


------------------------------------
-- Cross-Border Fraud
------------------------------------
SELECT
    u.country AS user_country,
    t.ip_country AS transaction_country,
    COUNT(*) AS transactions,
    SUM(CAST(is_chargeback AS INT)) AS fraud_cases
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
WHERE u.country <> t.ip_country
GROUP BY u.country, t.ip_country
ORDER BY fraud_cases DESC;


------------------------------------
-- Cross-Border Vs Domestic Fraud
------------------------------------
SELECT
    CASE
        WHEN t.ip_country = u.country THEN 'Domestic'
        ELSE 'Cross-Border'
    END AS transaction_type,
    COUNT(*) total_transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*),2)
        AS DECIMAL(5,2)) fraud_rate
FROM transactions t
JOIN users u
ON t.user_id = u.user_id
GROUP BY
    CASE
        WHEN t.ip_country = u.country THEN 'Domestic'
        ELSE 'Cross-Border'
    END;


------------------------------------
-- Fraud Trend (Campaign Detection)
------------------------------------
SELECT
    FORMAT(transaction_time,'yyyy-MM') AS transaction_month,
    COUNT(*) total_transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_transactions,
    CAST(ROUND(100.0 * SUM(CAST(is_chargeback AS INT)) / COUNT(*),2)
        AS DECIMAL(5,2)) fraud_rate
FROM transactions
GROUP BY FORMAT(transaction_time,'yyyy-MM')
ORDER BY transaction_month;


------------------------------------
-- High-Risk Users
------------------------------------
SELECT
    user_id,
    COUNT(*) total_transactions,
    SUM(CAST(is_chargeback AS INT)) fraud_transactions
FROM transactions
GROUP BY user_id
HAVING SUM(CAST(is_chargeback AS INT)) >= 3
ORDER BY fraud_transactions DESC;


------------------------------------
-- Risk Score Distribution
------------------------------------
SELECT
    CASE
        WHEN risk_score >= 60 THEN 'High Risk'
        WHEN risk_score >= 30 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_level,
    COUNT(*) AS transactions
FROM vw_fraud_risk_scores
GROUP BY
    CASE
        WHEN risk_score >= 60 THEN 'High Risk'
        WHEN risk_score >= 30 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END
ORDER BY transactions DESC;


------------------------------------
-- Investigation Queue
------------------------------------
SELECT TOP 50
    transaction_id,
    user_id,
    amount,
    payment_method,
    ip_country,
    risk_score
FROM vw_fraud_risk_scores
ORDER BY risk_score DESC;
