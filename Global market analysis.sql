#NY Sales data
select round(sum(sales),0)
from (
	SELECT * 
	FROM grolab_store.`global_superstore_data analysis_project`
    
) e
where state = 'New York'
#count of distinct country and total sold amount for each row
select
from (
	select
	count(state) as count_country, country, round(sum(sales),0) as sum_amount
	from grolab_store.`global_superstore_data analysis_project`
	group by country
) db
order by sum_amount desc
select max(ttl_amount) as max, country
from (
	select country, sum(sales) as ttl_amount
	from grolab_store.`global_superstore_data analysis_project`
	group by country
) countrysales
group by country
select 
distinct outlet, concat(round(sum(sales),0), " ", "K") / 1000, row_number() over(order by outlet)
from grolab_store.`global_superstore_data analysis_project`
group by outlet



