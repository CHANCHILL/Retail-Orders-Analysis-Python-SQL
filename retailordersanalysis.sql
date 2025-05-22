
--Create table retail_orders to append data from dataframe df
DROP TABLE IF EXISTS retail_orders;
Create table retail_orders(
order_id INT PRIMARY KEY,
order_date DATE,
ship_mode VARCHAR(20),
segment VARCHAR(20),
country VARCHAR(20),
city VARCHAR(20),
state VARCHAR(20),
postal_code VARCHAR(20),
region VARCHAR(20),
category VARCHAR(20),
sub_category VARCHAR(20),
product_id VARCHAR(20),
cost_price decimal(7,2),
list_price decimal(7,2),
quantity INT,
discount_percent INT,
discount decimal(7,2),
sale_price decimal(7,2),
profit decimal(7,2)
)


SELECT * FROM retail_orders;

--find the top 10 highest revenue generating products
SELECT product_id, SUM(quantity*sale_price) AS total_revenue
FROM retail_orders
GROUP BY product_id
ORDER BY total_revenue DESC
LIMIT 10;

--find top 5 highest selling products in each region 
--1. using CTE 
WITH region_sales AS 
	(SELECT region, product_id, 
	SUM(quantity*sale_price) AS total_revenue,
	ROW_NUMBER() OVER(PARTITION BY region ORDER BY SUM(quantity*sale_price) DESC) AS rank
	FROM retail_orders
	GROUP BY region, product_id
)
SELECT region, product_id, total_revenue
FROM region_sales
WHERE rank<=5
ORDER BY region, total_revenue DESC;

-- 2. using Subquery
SELECT region, product_id, total_revenue
FROM
	(SELECT region, product_id, 
	SUM(quantity*sale_price) AS total_revenue,
	ROW_NUMBER() OVER(PARTITION BY region ORDER BY SUM(quantity*sale_price) DESC) AS rank
	FROM retail_orders
	GROUP BY region, product_id
) region_sales
WHERE rank<=5
ORDER BY region, total_revenue DESC;

--find the month over month growth comparison for 2022 and 2023 sales eg: JAN 2022 vs JAN 2023
SELECT 
EXTRACT(MONTH FROM order_date) AS Month,
SUM(CASE 
WHEN EXTRACT(YEAR FROM order_date)= 2022 THEN quantity*sale_price END) AS total_revenue_2022,
SUM(CASE 
WHEN EXTRACT(YEAR FROM order_date)= 2023 THEN quantity*sale_price END) AS total_revenue_2023
FROM retail_orders
GROUP BY EXTRACT (MONTH FROM order_date)
ORDER BY Month;

--find which month had highest sales for each category?
With categorymonth_sales AS (
	SELECT category, 
	TO_CHAR(order_date,'YYYY/MM') AS YearMonth,
	SUM(quantity*sale_price) AS total_revenue,
	ROW_NUMBER() OVER(PARTITION BY category ORDER BY SUM(quantity*sale_price) DESC) AS rank
	FROM retail_orders
	GROUP BY category, TO_CHAR(order_date,'YYYY/MM')
)

SELECT category, YearMonth, total_revenue 
FROM categorymonth_sales
WHERE rank=1
ORDER BY category;

--which sub-category had the highest growth by profit in 2023 compare to 2022?

With category_revenuecomparison AS(
	SELECT sub_category,
	SUM(CASE WHEN EXTRACT(YEAR FROM order_date)= 2022 THEN (quantity*sale_price)-(quantity*cost_price) END) AS total_profit_2022,
	SUM(CASE WHEN EXTRACT(YEAR FROM order_date)= 2023 THEN (quantity*sale_price)-(quantity*cost_price) END) AS total_profit_2023
	FROM retail_orders
	GROUP BY sub_category
)

SELECT sub_category, 
ROUND((total_profit_2023-total_profit_2022)*100/total_profit_2022::numeric,2) AS Profit_Growth_percentage
--Profit Growth % = (increase in profit from 2022 to 2023)/total profit in 2022
FROM category_revenuecomparison
ORDER BY Profit_Growth_percentage DESC
LIMIT 1;