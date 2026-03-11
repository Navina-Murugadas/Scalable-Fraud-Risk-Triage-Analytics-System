/* ==========================================
   IMPORT CHARGEBACKS
   ========================================== */

BULK INSERT chargebacks
FROM 'N:\Data Analysis PROJECTS\#DA PROJECTS\Scalable Fraud Risk Triage & Analytics System - SQL, PowerBI, Gemini AI\fraud-risk-analytics-system\data\raw\chargebacks.csv'
WITH (
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
