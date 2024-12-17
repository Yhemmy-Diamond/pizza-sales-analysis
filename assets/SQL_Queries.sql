-- Pizza Sales Oueries

SELECT * FROM pizza_sales;

/* 
	1. KPI's
	Total Revenue
*/	
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

-- Average Order Value
SELECT SUM(total_price)/ COUNT (DISTINCT order_id) AS Avg_Order_Value FROM pizza_sales;


-- Total Pizza Sold
SELECT SUM (quantity) AS Total_Pizza_Sold FROM pizza_sales;


-- Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales; 


-- Average Pizza Per Order
SELECT CAST(CAST(SUM (quantity) AS DECIMAL(10,2))/ 
	CAST (COUNT(DISTINCT order_id)AS DECIMAL(10,2))
		AS DECIMAL(10,2)) FROM pizza_sales;

-- OR
SELECT CAST(SUM (quantity) AS DECIMAL(10,2))/ COUNT(DISTINCT order_id)FROM pizza_sales;


-- Daily Trend for Total Orders
SELECT TO_CHAR(order_date, 'Day') AS order_day, COUNT(DISTINCT order_id) AS total_orders
	FROM pizza_sales
	GROUP BY TO_CHAR(order_date, 'Day'), EXTRACT(DOW FROM order_date)
	ORDER BY EXTRACT(DOW FROM order_date) ASC;


-- Monthly Trend for Total Orders
SELECT TO_CHAR(order_date, 'Month') AS order_month, COUNT(DISTINCT order_id) AS Total_orders
	FROM pizza_sales
	GROUP BY TO_CHAR(order_date, 'Month')
	ORDER BY Total_orders ASC;


-- % of Sales by Pizza Category
SELECT pizza_category, sum(total_price) as Total_Sales, sum(total_price) * 100 / 
	(SELECT sum(total_price) FROM pizza_sales)AS Percentage_of_TotalSales
	FROM pizza_sales 
	GROUP BY pizza_category;


-- % of Sales by Pizza Size
SELECT pizza_size,
	CAST(sum(total_price)AS DECIMAL(10,2)) as Total_Sales, 
	CAST (sum(total_price) * 100 / 
		(SELECT sum(total_price) FROM pizza_sales)AS DECIMAL(10,2)) AS Percentage_of_TotalSales
FROM pizza_sales 
WHERE EXTRACT(quarter FROM order_date)= 1 
GROUP BY pizza_size
ORDER BY Percentage_of_TotalSales DESC;


-- Top 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price)AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Revenue DESC;


-- Bottom 5 Pizzas by Revenue
SELECT pizza_name, SUM(total_price)AS Total_Revenue FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Revenue ASC
	LIMIT 5;


-- Top 5 Pizzas by Quantity
SELECT pizza_name, SUM(quantity)AS Total_Quantity FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Quantity DESC
	LIMIT 5;


-- Bottom 5 Pizzas by Quantity
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Orders ASC
	LIMIT 5;


-- Top 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Orders DESC
	LIMIT 5;

-- Bottom 5 Pizzas by Total Orders
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
GROUP BY pizza_name
	ORDER BY Total_Orders ASC
	LIMIT 5;


-- Pizza Category using Where Clause
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales
WHERE pizza_category = 'Classic'
	GROUP BY pizza_name
	ORDER BY Total_Orders ASC
	LIMIT 5;










