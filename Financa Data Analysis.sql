--Gross margin by segment
with t1 as (
SELECT 
	segment, SUM(Gross_sales) AS Gross_sales, SUM(sales - cogs) AS Gross_Profit
FROM [dbo].[Financial analysis]
GROUP BY segment)
SELECT Segment, CONCAT(Gross_Profit / Gross_sales * 100, '%')
FROM t1
--discount distribution by segment & product
SELECT 
	segment, product, -(SUM(sales)/SUM(Gross_sales) - 1) as dsc
FROM [dbo].[Financial analysis]
GROUP BY Segment, product 
--most profitbale country
SELECT * 
FROM Profit_country WHERE profit = 
(SELECT MAX(profit) AS max 
	FROM Profit_country)
--profit by country
SELECT
	country,
	SUM(sales) - SUM(cogs) AS profit
FROM dbo.[Financial analysis]
GROUP BY Country
ORDER BY profit DESC
--sales amount by year, month compared to PM 
WITH cte as (
SELECT date, SUM(sales) AS CM, 
	LAG(sum(sales)) OVER(ORDER BY date) AS PM
FROM [dbo].[Financial analysis]
GROUP BY date
)
SELECT *, CONCAT(CM / PM * 100, '%') AS increase_vs_PM
FROM cte
--product sales cy vs py
SELECT product, year, sum(sales) as sales, LAG(sum(sales)) over(order by product) as lg
FROM [dbo].[Financial analysis]
GROUP BY product, year



SELECT 
	*
FROM [dbo].[Financial analysis]

