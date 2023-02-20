--ranking company name depending on revenue
SELECT *,
		CONCAT(ROUND(profit / revenue, 3) * 100, '', '%') AS GM
FROM (
	SELECT 
		company,
		  SUM([Revenue (in millions)]) AS 'revenue',
			SUM([Profit (in millions)]) AS 'profit',
				ROW_NUMBER() over(order by SUM([Revenue (in millions)]) DESC) as rank
	FROM  [dbo].[fortune500$]
GROUP BY company ) AS T1
--total gross profit share by company
SELECT company,
		SUM([Profit (in millions)]) AS 'profit',
		SUM([Profit (in millions)]) / ( 
			SELECT SUM([Profit (in millions)])
				FROM [dbo].[fortune500$]) * 100 AS '% share'
FROM [dbo].[fortune500$]
GROUP BY company
ORDER BY profit desc
--top 5 profitable company with gross margin last 5 year
WITH t1 as (
	SELECT *,
			RANK() over(partition by year order by profit, year asc) as rankx
	FROM (
		SELECT Company, year, SUM([Profit (in millions)]) AS 'profit'
		FROM [dbo].[fortune500$]
		GROUP BY Company, year) DB
	WHERE YEAR IN (2005, 2006, 2007, 2008, 2009))  
SELECT  TOP 5 Company, YEAR, profit, rankx
FROM t1
ORDER BY profit desc


SELECT top 5 YEAR, SUM([Revenue (in millions)]) AS Rev, SUM([Profit (in millions)]) AS Profit
FROM [dbo].[fortune500$]
GROUP BY year
ORDER BY Year DESC

SELECT TOP 5 company, sum([Revenue (in millions)]) as rev
FROM [dbo].[fortune500$]
GROUP BY company
ORDER BY sum([Revenue (in millions)]) DESC




