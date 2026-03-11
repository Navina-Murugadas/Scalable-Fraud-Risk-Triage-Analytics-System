/* ==========================================
   IMPORT TRANSACTIONS
   ========================================== */

INSERT INTO transactions
SELECT
    CAST(transaction_id AS BIGINT),
    CAST(user_id AS INT),
    CAST(transaction_time AS DATETIME2),
    CAST(amount AS DECIMAL(18,2)),
    currency,
    payment_method,
    merchant_category,
    device_type,
    ip_country,
    status,
    CAST(is_chargeback AS BIT),
    CAST(is_ato_user AS BIT)
FROM staging_transactions;
