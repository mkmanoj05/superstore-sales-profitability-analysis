select * from Superstore1 s ;

alter table Superstore1 
RENAME  column "Month Name" to "month_name";

--sales and profit by month
SELECT month_name,sum(sales) as total_revenue ,sum(s.Profit ) as total_profit from Superstore1 s 
group by month_name 
order by sum(profit) desc;

--sales,profit, profit_margin by year 
with cte1 as 
(select year,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by year)
select year,total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
order by year;

--sales,profit,profit_margin by ship mode
with cte1 as 
(select s."Ship Mode" ,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by "Ship Mode")
select "Ship Mode",total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
order by total_profit;

--Top 10 customer giving highest profit value
SELECT s."Customer Name" ,sum(sales) as total_revenue ,sum(s.Profit ) as total_profit from Superstore1 s 
group by "Customer Name" 
order by sum(profit) desc
limit 10;

--sales,profit,profit_margin by segment
with cte1 as 
(select segment ,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by segment)
select segment,total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
order by total_profit;

--sales,profit, profit_margin by city
with cte1 as 
(select city ,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by city)
select city,total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
where total_revenue>10000
order by profit_margin desc 
;

--sales,profit, avg_discount by state and region
select state,region,sum(Sales) as total_revenue ,sum(profit) as total_profit
,avg(Discount ) as avg_discount from Superstore1 
group by state,region 
order by region,State ;

--sales,profit, profit_margin by category
with cte1 as 
(select category,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by category)
select category,total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
where total_revenue>10000
order by profit_margin desc ;

--sales,profit, profit_margin by sub category
with cte1 as 
(select s."Sub-Category" ,sum(sales) as total_revenue, sum(s.Profit ) as total_profit
from Superstore1 s 
group by "Sub-Category" )
select "Sub-Category" ,total_revenue,total_profit,
total_profit/total_revenue*100.00 as profit_margin from cte1 
where total_revenue>10000
order by cte1.total_profit  desc ;


--running revenue in year 2014
with cte as
(select month,sum(sales) as total_sales
from Superstore1 s 
where year = 2014
group by month
ORDER BY month
) select month,sum(total_sales) over(order by month) as running_revenue
from cte
order by month
;


--top 10 products with highest sales value
select "Product Name",sum(sales) as total_revenue
from Superstore1 s 
group by "Product Name" 
order by sum(sales) desc
limit 10 ;


--top 10 products with highest profit value
select "Product Name",sum(profit) as total_revenue
from Superstore1 s 
group by "Product Name" 
order by sum(profit) desc
limit 10 ;


-- does higher discount has higher profit 
select city,sum(sales),SUM(profit),concat(avg(discount)*100.00,"%")as discount_percentage
from Superstore1 
group by city
order by sum(profit) desc;
--no


select "Sub-Category" ,sum(sales),SUM(profit),concat(avg(discount)*100.00,"%")as discount_percentage
from Superstore1 
group by "Sub-Category" 
order by sum(profit) desc;
