/* ==========================================
   IMPORT TRANSACTIONS
   ========================================== */

CREATE TABLE staging_transactions (
    transaction_id VARCHAR(50),
    user_id VARCHAR(50),
    transaction_time VARCHAR(50),
    amount VARCHAR(50),
    currency VARCHAR(10),
    payment_method VARCHAR(50),
    merchant_category VARCHAR(50),
    device_type VARCHAR(50),
    ip_country VARCHAR(50),
    status VARCHAR(20),
    is_chargeback VARCHAR(10),
    is_ato_user VARCHAR(10)
);


BULK INSERT staging_transactions
FROM 'N:\Data Analysis PROJECTS\#DA PROJECTS\Scalable Fraud Risk Triage & Analytics System - SQL, PowerBI, Gemini AI\fraud-risk-analytics-system\data\raw\transactions.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    CODEPAGE = '65001',
    TABLOCK
);

