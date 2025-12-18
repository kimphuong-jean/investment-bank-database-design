use banksdata;

select * from c_sociodemographic;
-- Using concat to show the loan amount and term
SELECT CONCAT('€', Amount,' for ', Term_month, ' months') AS Loan_description,
Customer_ID
FROM Loan_Form;

-- Update the marriage status of a customer
UPDATE c_sociodemographic
SET Marriage_status = 'Married'
WHERE Customer_ID = 9010;

-- Delete a row in customer table
DELETE FROM Customer
WHERE Customer_ID = 9001;

-- Search by condition: Find customers with Total_asset > 100,000
SELECT Customer_ID, Total_asset
FROM c_finance
WHERE Total_asset > 100000;

-- Aggregate function 
-- 1. Count how many customers in one county:
SELECT Address, COUNT(*) AS number_of_customers
FROM Customer
GROUP BY Address;

-- 2. Calculate the average yearly income of customers
SELECT AVG(Yearly_income) AS 'Average yearly income'
FROM c_finance;


-- Using join to show the manager of staffs
SELECT
  ca.Emp_ID        AS Analyst_ID,
  sa.Staff_name    AS Analyst_name,
  sm.Staff_name    AS Manager_name,
  sa.Bank_ID
FROM Credit_analyst ca
JOIN Staff sa ON ca.Emp_ID = sa.Emp_ID -- Join emp_ID in credit analyst table with emp_id in staff table
JOIN Staff sm ON ca.Supervised_by = sm.Emp_ID -- join emp_id in manager table with supervised_by in credit analyst table
ORDER BY sa.Bank_ID;

-- Using subquery to find customers whose total asset is higher than the average total asset 
SELECT Customer_ID, Total_asset
FROM c_finance
WHERE Total_asset > (
	SELECT AVG(Total_asset)
	FROM c_finance
    );


