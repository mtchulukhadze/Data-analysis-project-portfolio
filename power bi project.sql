--calculate share by region
WITH cte1 AS (
SELECT 
DISTINCT region,
	SUM(sales) OVER(PARTITION BY region) AS sum_region
FROM [dbo].[Sample _Superstore]),
cte2 AS(
SELECT 
	SUM(sales) AS total
FROM [dbo].[Sample _Superstore])
SELECT Region, sum_region, total, sum_region / total *100  AS 'percent'
FROM cte1, cte2
--category table
SELECT 
	category,
	SUM(sales),
	SUM(profit),
	CONCAT(ROUND(SUM(profit) / SUM(sales),3) * 100, '%') AS d
FROM [dbo].[Sample _Superstore]
GROUP BY category
--customer count by city
SELECT
	COUNT(customer_id) AS count,
	city,
	round(avg(sales),2)
FROM [dbo].[Sample _Superstore]
GROUP BY city

SELECT * FROM [dbo].[Sample _Superstore]







