USE bank_customer_curn_analysis;
SELECT * FROM bank_churn;

-- 1. Total Customers --

SELECT COUNT(*)
FROM bank_churn;


-- 2. Churned Customers --

SELECT SUM(Exited) AS Customers_Churned
FROM bank_churn;

-- 3. Non Churned Customers --
SELECT SUM(Exited) AS Non_Churned_Customers
FROM bank_churn
WHERE Exited = 0;


-- 4. Churn Rate -- 
-- 4.1 Run this to get the percentage then 4.2 -- 
SELECT
	SUM(Exited)/COUNT(*)*100 AS Churn_Rate
FROM bank_churn;

-- 4.2 Run this to to divide with the churn_rate percentage -- 
SELECT
	ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn;


-- 5. Churn Rate by Gender -- 
-- We have to get the Gender | Total Customers | Churned Customers |  Churn Rate-- 

SELECT 
		Gender,
        COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY Gender;


-- 6. Churn By Activity Rate --
SELECT 
		CASE
			WHEN IsActiveMember = 1 THEN 'ACTIVE'
            ELSE 'INACTIVE'
            END AS Activity_Status,
        COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY Activity_Status;


-- 7 Customers by Credit Card Status --
-- Same query as the previous one, we are now focused on the HasCrCard Coluomn--
SELECT 
		CASE
			WHEN HasCrCard = 1 THEN 'Owned'
            ELSE 'Not Owned'
            END AS Credit_Card_Status,
        COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY  Credit_Card_Status;


-- 8 Churn By Country -- 
-- Same query as the previous one, we are now focused on the Geography Coluomn--
SELECT
		Geography,
		COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY Geography
ORDER BY Total_Customers DESC;

-- 9 Churn By Age Group --
-- First check the minimun age and the max age --

SELECT MIN(AGE) FROM bank_churn;
SELECT MAX(AGE) FROM bank_churn;

-- Now we group them by age --

SELECT
		CASE
			WHEN Age between 18 and 20 THEN '18 - 20'
            WHEN Age between 21 and 30 THEN '21 - 30'
            WHEN Age between 31 and 40 THEN '31 - 40'
            WHEN Age between 41 and 50 THEN '41 - 50'
            WHEN Age between 51 and 60 THEN '51 - 60'
            ELSE '61+'
		END AS AGE_Group,
        COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY Age_Group
ORDER BY Age_Group;


-- 10 Churn By Credit Scrore --
-- First check the minimun credit score and the max credit score, same query as the previous one --
SELECT MIN(CreditScore) FROM bank_churn;
SELECT MAX(CreditScore) FROM bank_churn;

SELECT
		CASE
			WHEN CreditScore between 0 and 400 THEN '0 - 400'
            WHEN CreditScore between 401 and 500 THEN '401 - 500'
            WHEN CreditScore between 501 and 600 THEN '501 - 600'
            WHEN CreditScore between 601 and 700 THEN '601 - 700'
            WHEN CreditScore between 701 and 800 THEN '701 - 800'
            ELSE '800+'
		END AS Credit_Score_Bucket,
        COUNT(*) AS Total_Customers,
        SUM(Exited) AS Customers_Churned,
        ROUND(SUM(Exited)/COUNT(*)*100,1) AS Churn_Rate
FROM bank_churn
GROUP BY Credit_Score_Bucket
ORDER BY Credit_Score_Bucket;