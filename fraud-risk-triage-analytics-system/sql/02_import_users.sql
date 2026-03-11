/* ==========================================
   IMPORT USERS
   ========================================== */

BULK INSERT users
FROM 'N:\Data Analysis PROJECTS\#DA PROJECTS\Scalable Fraud Risk Triage & Analytics System - SQL, PowerBI, Gemini AI\fraud-risk-analytics-system\data\raw\users.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);


SELECT 'Users Count' AS table_name, COUNT(*) AS total_rows
FROM users;

