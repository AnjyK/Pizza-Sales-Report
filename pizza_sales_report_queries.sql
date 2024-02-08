select * from [Pizza DB].dbo.pizza_sales

/* Total Revenue = Sum of Total_Price */
select sum(total_price) as Total_Revenue from [Pizza DB].dbo.pizza_sales

/* Average order value = Total revenue / Total order placed */
select sum(total_price)/count(distinct(order_id)) as Average_Order_Value from [Pizza DB].dbo.pizza_sales

/* Total Pizza's sold */
select sum(quantity) as Total_Pizza_Sold from [Pizza DB].dbo.pizza_sales

/* Total orders placed */
select count(distinct(order_id)) as Total_Orders_Placed from [Pizza DB].dbo.pizza_sales

/* Average pizza's per order = total no of pizza's sold / total no of orders placed */
select cast(cast(sum(quantity) as decimal (10,2))/cast(count(distinct(order_id)) as decimal (10,2)) as decimal (10,2)) as Average_Pizza_per_Order 
from [Pizza DB].dbo.pizza_sales

/* Daily Trend - how many pizza's are sold every day of the week */
select datename(dw, order_date) as Day_of_the_week, count(distinct(order_id)) as Total_Orders 
from [Pizza DB].dbo.pizza_sales
group by datename(dw, order_date)
order by datename(dw, order_date)

/* Monthly trend of orders -how many pizza's are sold in each month in a year */
select datename(month, order_date) as Month_of_the_year, count(distinct(order_id)) as Total_Orders 
from [Pizza DB].dbo.pizza_sales
group by datename(month, order_date)

/* Percentage of pizza sold by category */
select pizza_category, sum(total_price) as Total_Price, sum(total_price)*100 / (select sum(total_price) from [Pizza DB].dbo.pizza_sales) as PCT
from [Pizza DB].dbo.pizza_sales
group by pizza_category

/* Filtering total sales by month for each category of pizza */
select pizza_category, sum(total_price) as Total_Price, sum(total_price)*100 / (select sum(total_price) from [Pizza DB].dbo.pizza_sales where month(order_date) = 1) as PCT
from [Pizza DB].dbo.pizza_sales
where month(order_date) = 1
group by pizza_category

/* Percentage of pizza sold by pizza size */
select pizza_size, cast(sum(total_price)as decimal(10,2)) as Total_Price, cast(sum(total_price)*100 / (select sum(total_price) from [Pizza DB].dbo.pizza_sales) as decimal (10,2)) as PCT
from [Pizza DB].dbo.pizza_sales
group by pizza_size
order by PCT desc

/* Percentage of pizza sold by pizza size for particular quarter */
select pizza_size, cast(sum(total_price)as decimal(10,2)) as Total_Price, cast(sum(total_price)*100 / 
(select sum(total_price) from [Pizza DB].dbo.pizza_sales where datepart(quarter, order_date) = 3) as decimal (10,2)) as PCT
from [Pizza DB].dbo.pizza_sales
where datepart(quarter, order_date) = 3
group by pizza_size
order by PCT desc

/*Total Pizzas Sold by Pizza Category */
select pizza_category, SUM(quantity) as Total_Quantity_Sold
from [Pizza DB].dbo.pizza_sales
where MONTH(order_date) = 2
group by pizza_category
order by Total_Quantity_Sold DESC


/* Top 5 best sellers by Revenue*/
select TOP 5 pizza_name,sum(total_price) as Total_Revenue
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Revenue Desc

/* Bottom 5 worst sellers by Revenue*/
select TOP 5 pizza_name,sum(total_price) as Total_Revenue
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Revenue ASC

/* Top 5 best sellers by Quantity*/
select TOP 5 pizza_name,sum(quantity) as Total_Quantity
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Quantity Desc

/* Bottom 5 worst sellers by Quantity*/
select TOP 5 pizza_name,sum(total_price) as Total_Quantity
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Quantity ASC

/* Top 5 best sellers by Orders*/
select TOP 5 pizza_name,count(distinct(order_id)) as Total_Orders
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Orders Desc

/* Bottom 5 worst sellers by Quantity*/
select TOP 5 pizza_name,count(distinct(order_id)) as Total_Orders
from [Pizza DB].dbo.pizza_sales
group by pizza_name
order by Total_Orders ASC