CREATE DATABASE FraudAnalyticsDB;
GO

USE FraudAnalyticsDB;
GO

CREATE TABLE users (
    user_id INT PRIMARY KEY,
    signup_date DATE NOT NULL,
    country VARCHAR(50) NOT NULL,
    prior_chargebacks INT NOT NULL,
    account_age_days INT NOT NULL,
    high_risk_user BIT NOT NULL
);

CREATE TABLE transactions (
    transaction_id BIGINT PRIMARY KEY,
    user_id INT NOT NULL,
    transaction_time DATETIME2 NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    currency VARCHAR(10) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    merchant_category VARCHAR(50) NULL,
    device_type VARCHAR(30) NULL,
    ip_country VARCHAR(50) NULL,
    status VARCHAR(20) NOT NULL,
    is_chargeback BIT NOT NULL,
    is_ato_user BIT NOT NULL,
    
    CONSTRAINT FK_transactions_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);

CREATE TABLE chargebacks (
    transaction_id BIGINT PRIMARY KEY,
    user_id INT NOT NULL,
    chargeback_date DATETIME2 NOT NULL,
    amount DECIMAL(18,2) NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    merchant_category VARCHAR(50) NULL,
    reason VARCHAR(100) NOT NULL,
    
    CONSTRAINT FK_chargebacks_transactions
        FOREIGN KEY (transaction_id)
        REFERENCES transactions(transaction_id),
        
    CONSTRAINT FK_chargebacks_users
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
);


--DROP TABLE IF EXISTS chargebacks;
--DROP TABLE IF EXISTS transactions;
--DROP TABLE IF EXISTS users;
--DROP TABLE IF EXISTS staging_transactions;

/* ==========================================
   VALIDATION CHECKS
   ========================================== */

SELECT * FROM users;
SELECT * FROM transactions;
SELECT * FROM chargebacks;

SELECT TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE';

EXEC sp_help 'users';
EXEC sp_help 'transactions';
EXEC sp_help 'chargebacks';

SELECT 
    name AS FK_Name,
    OBJECT_NAME(parent_object_id) AS Table_Name
FROM sys.foreign_keys;

EXEC sp_helpindex 'chargebacks';
EXEC sp_helpindex 'transactions';
EXEC sp_helpindex 'users';

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'transactions';


SELECT 'Users Count' AS table_name, COUNT(*) AS total_rows
FROM users;

SELECT 'Transactions Count' AS table_name, COUNT(*) AS total_rows
FROM transactions;

SELECT 'Chargebacks Count' AS table_name, COUNT(*) AS total_rows
FROM chargebacks;