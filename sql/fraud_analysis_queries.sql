--CREATING DATABASE
CREATE DATABASE fraud_db;

--USING DATABASE
USE fraud_db;

--KNOWING THE TRASACTION TABLE
EXEC sp_help transactions_raw;

--TOP 10 RECORDS FROM TRANSACTION
SELECT TOP 10 * FROM transactions_raw;

--TOTAL TRANSACTIONS
SELECT COUNT(*) AS Total_Transaction FROM transactions_raw;

--TOTAL NUMBER OF FRAUD TRANSACTION
SELECT COUNT(is_fraud) AS No_of_fraud FROM transactions_raw
WHERE is_fraud = 1;

--FRAUD PERCENTAGE
SELECT (CAST(SUM(CASE WHEN is_fraud=1 THEN 1 ELSE 0 END )AS FLOAT)/COUNT(*))*100 AS Fraud_Percentage
FROM transactions_raw;

--FRAUD BY HOUR
SELECT hour, COUNT(*) AS fraud_count FROM transactions_raw
WHERE is_fraud=1
GROUP BY hour ORDER BY fraud_count DESC;

--HIGH AMOUNT FRAUD
SELECT TOP 20 amt FROM transactions_raw
WHERE is_fraud=1
ORDER BY amt;

--AVG FRAUD AMOUNT 
SELECT AVG(amt) AS Average_Fraud_Amount FROM transactions_raw
WHERE is_fraud=1;

--REPEATED CUSTOMER FRAUD
SELECT firstname,lastname,COUNT(*) AS fraud_count FROM transactions_raw
WHERE is_fraud=1
GROUP BY cc_num,firstname,lastname
ORDER BY fraud_count DESC;

--REPEATED LOCATION FRAUD
SELECT state, COUNT(*) fraud_cases
FROM transactions_raw
WHERE is_fraud = 1
GROUP BY state
ORDER BY fraud_cases DESC;

--REPEATED JOB FRAUD
SELECT job,COUNT(*) AS fraud_count FROM transactions_raw
WHERE is_fraud=1
GROUP BY job
ORDER BY fraud_count DESC;
