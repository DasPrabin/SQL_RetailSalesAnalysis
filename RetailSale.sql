-- SQL PROJECT RETAIL SALES ANALYSIS --

CREATE DATABASE SQL_Prject_1;

USE SQL_Prject_1;

CREATE TABLE RetailSale(
    transactions_id	 int PRIMARY KEY,
    sale_date Date,
	sale_time Time,
	customer_id	int,
    gender varchar(6),
	age int,
	category varchar(15),
	quantiy int,
	price_per_unit double,
	cogs double,
	total_sale double
    );
    
    SELECT count(*) FROM RetailSale;
  - ---------------------------  
    SELECT * FROM Retailsale
    WHERE transactions_id IS NULL
    OR 
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR 
    customer_id IS NULL
    OR 
    gender IS NULL
    OR 
    age IS NULL
    OR 
    category IS NULL
    OR 
    quantiy IS NULL
    OR 
    price_per_unit IS NULL
    OR 
    cogs IS NULL
    OR 
    total_sale IS NULL;

	-- how many sale we have.
    SELECT COUNT(*) 
    FROM retailSale;
    
    -- How Many UNIQE customer we Have.
    SELECT COUNT(DISTINCT customer_id)
    FROM retailSale;
    
    -- How many category we have
     SELECT COUNT(DISTINCT category) AS Total_Category
    FROM retailSale;

-- Business Key Problem 
-- Write a SQL query to retrieve all columns for sales made on '2022-11-05:

 SELECT * 
 FROM retailsale
 WHERE sale_date = '2022-11-05';

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' 
-- and the quantity sold at least 4 in the month of Nov-2022:

SELECT * FROM retailsale
WHERE category = 'Clothing'
AND quantiy >=4
AND DATE_FORMAT(sale_date,'%Y-%m') = '2022-11';

-- Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category,SUM(total_sale)
FROM retailsale 
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT ROUND(AVG(age)) AS Cx_age
FROM retailsale
WHERE category = 'Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000.:

SELECT * 
FROM retailsale
WHERE total_sale > 1000;

-- Write a SQL query to find the total number of transactions 
-- (transaction_id) made by each gender in each category.:

SELECT gender,category,COUNT(transactions_id) AS txn_count
FROM retailsale
GROUP BY gender,category
ORDER BY 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:

SELECT 
DATE_FORMAT(sale_date,'%Y') AS Year,
DATE_FORMAT(sale_date,'%m') AS Month,
ROUND(AVG(total_sale),2) AS avg_SALE
FROM retailsale
GROUP BY Year,Month 
ORDER BY  avg_SALE DESC
Limit 2;


SELECT 
Year,Month,Avg_SALE
FROM
(
SELECT 
DATE_FORMAT(sale_date,'%Y') AS Year,
DATE_FORMAT(sale_date,'%M') AS Month,
ROUND(AVG(total_sale),2) AS avg_SALE,
RANK() OVER(PARTITION BY DATE_FORMAT(sale_date,'%Y') ORDER BY ROUND(AVG(total_sale),2) DESC) AS rank_no
FROM retailsale
GROUP BY Year,Month 
ORDER BY 1,3 DESC
) AS sub
 WHERE rank_no = 1;
;

-- Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT 
customer_id,
sum(total_sale) AS total_sale
FROM  retailsale
GROUP BY customer_id 
ORDER BY total_sale DESC
 LIMIT 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT
category,
COUNT(DISTINCT customer_id) AS Unique_CX
FROM retailsale
GROUP BY category;

-- Write a SQL query to create each shift and number of orders 
-- (Example Morning <12, Afternoon Between 12 & 17, Evening >17):

 with Shiftwise_sale
 AS
 (SELECT *,
 CASE
 WHEN TIME_FORMAT(sale_time,'%H') < 12 THEN 'Morning'
 WHEN  TIME_FORMAT(sale_time,'%H') BETWEEN 12 AND 17 THEN 'Afternoon'
 WHEN  TIME_FORMAT(sale_time,'%H') BETWEEN 17 AND 21 THEN 'Evening'
 ELSE 'Night'
 END AS Shift
FROM retailsale
)
SELECT 
Shift,
COUNT(transactions_id) AS total_Orders
 FROM Shiftwise_sale
 GROUP BY Shift;



