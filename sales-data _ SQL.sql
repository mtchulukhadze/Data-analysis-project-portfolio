SELECT 
  state, 
  round(sum(sales),0) as revenue, 
  DENSE_RANK() OVER(ORDER BY sum(sales) desc)  as "rank"
FROM data_analysis.sales_data 
GROUP BY state;

SELECT 
	RIGHT(`Order Date`, 4) AS YEAR, 
    ROUND(SUM(Profit), 0) AS rev,
    lag(ROUND(SUM(Profit),0)) over(order by RIGHT(`Order Date`, 4)) as PY
FROM data_analysis.sales_data 
GROUP BY year;
# top 5 most profitable company
SELECT * FROM (
	SELECT 
		State, 
		sum(Profit) as profit, 
			RANK() OVER(Order by sum(Profit) DESC) top5
	FROM data_analysis.sales_data 
	GROUP BY State) d
WHERE top5 <= 5;

SELECT 
	DISTINCT `Sub-Category`,
		round(sum(sales) OVER (PARTITION BY `Sub-Category`), 0) as amount, # sum for each cateogry
        round(sum(sales) OVER(),0) as "ttl sum", # total sum
        concat(round(sum(sales) OVER (PARTITION BY `Sub-Category`) / sum(sales) OVER() * 100, 2), "%") as "share %"
FROM data_analysis.sales_data ;


