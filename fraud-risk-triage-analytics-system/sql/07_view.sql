/* ==========================================
   Transaction Risk Scoring Model - VIEW
   ========================================== */

CREATE VIEW vw_fraud_risk_scores AS
WITH velocity_check AS (
    SELECT t1.transaction_id,
           COUNT(*) AS transactions_last_10min
    FROM transactions t1
    JOIN transactions t2
        ON t1.user_id = t2.user_id
        AND t2.transaction_time
            BETWEEN DATEADD(MINUTE,-10,t1.transaction_time)
            AND t1.transaction_time
    GROUP BY t1.transaction_id
)
SELECT
    t.transaction_id,
    t.user_id,
    t.amount,
    t.payment_method,
    t.ip_country,
    u.prior_chargebacks,
    v.transactions_last_10min,
    (   CASE WHEN t.ip_country IN ('Nigeria','Russia','Romania','Vietnam','Indonesia') THEN 30 ELSE 0 END +
        CASE WHEN t.payment_method = 'Crypto' THEN 20 ELSE 0 END +
        CASE WHEN t.amount > 500 THEN 15 ELSE 0 END +
        CASE WHEN v.transactions_last_10min >= 5 THEN 25 ELSE 0 END +
        CASE WHEN u.prior_chargebacks > 0 THEN 10 ELSE 0 END
    ) AS risk_score
FROM transactions t
JOIN users u ON t.user_id = u.user_id
LEFT JOIN velocity_check v
    ON t.transaction_id = v.transaction_id;


SELECT TOP 50*
FROM vw_fraud_risk_scores;