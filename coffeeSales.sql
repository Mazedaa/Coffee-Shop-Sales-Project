-- Select All --
SELECT * FROM coffee_shop.data;

-- First 10 data --
SELECT * FROM coffee_shop.data
Limit 10;

-- Total Sales By Month --
SELECT 
	Month_order,
    month_transaction,
	SUM(sales) AS total_sales
FROM coffee_shop.data
Group by month_transaction, Month_order
order by Month_order ASC;

-- Total Sales By Day Of the Week --
SELECT 
	Day_order,
    day_of_week,
	SUM(sales) AS total_sales
FROM coffee_shop.data
Group by day_of_week, Day_order
order by Day_order ASC;

-- Average Sales by Store -- 
SELECT 
	store_location,
    AVG(sales) AS average_sales_per_transaction
FROM coffee_shop.data
Group by store_location
order by average_sales_per_transaction DESC;

-- Monthly Sales Growth Percentage --
WITH monthly_sales AS (
    SELECT 
        month_transaction AS month,
        Month_order,
        SUM(sales) AS total_sales
	FROM coffee_shop.data
    GROUP BY 
        month_transaction, Month_order
)
SELECT 
    month,
    total_sales,
    LAG(total_sales) OVER (ORDER BY Month_order) AS previous_month_sales,
    ROUND(
        (total_sales - LAG(total_sales) OVER (ORDER BY Month_order)) / 
        LAG(total_sales) OVER (ORDER BY Month_order) * 100, 2
    ) AS sales_growth_percentage
FROM 
    monthly_sales
ORDER BY 
    Month_order;


-- Total Sales By Product Category --
SELECT 
    product_category,
    SUM(sales) AS total_sales
FROM 
	coffee_shop.data
GROUP BY 
    product_category
ORDER BY 
    total_sales DESC;

-- Top 5 Best-Selling Products
SELECT 
    product_item,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    product_item
ORDER BY 
    total_sales DESC
LIMIT 5;

-- Hourly Sales Trends -- 
SELECT 
    hour_transaction AS hour,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    hour_transaction
ORDER BY 
    hour ASC;

-- Sales by Store and Product Category -- 
SELECT 
    store_location,
    product_category,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    store_location, product_category
ORDER BY 
    store_location, total_sales DESC;

-- Total Quantity Solid by Product Type
SELECT 
    product_type,
    SUM(transaction_qty) AS total_quantity_sold
FROM 
    coffee_shop.data
GROUP BY 
    product_type
ORDER BY 
    total_quantity_sold DESC;

-- Average Sales per Day -- 
SELECT 
    transaction_date,
    SUM(sales) AS total_sales,
    AVG(sales) AS average_sales_per_transaction
FROM 
    coffee_shop.data
GROUP BY 
    transaction_date
ORDER BY 
    transaction_date ASC;

-- Sales by Day and Hour --
SELECT 
    day_of_week,
    hour_transaction AS hour,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    day_of_week, hour_transaction
ORDER BY 
    day_of_week, hour_transaction;

-- Sales by Product Size --
SELECT 
    product_size,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    product_size
ORDER BY 
    total_sales DESC;

-- High-value Transactions - Sales exceed £50  --
SELECT 
    transaction_id,
    transaction_date,
    sales
FROM 
    coffee_shop.data
WHERE 
    sales > 50
ORDER BY 
    sales DESC;

-- Sales by Product Detail --
SELECT 
    product_detail,
    SUM(sales) AS total_sales
FROM 
    coffee_shop.data
GROUP BY 
    product_detail
ORDER BY 
    total_sales DESC;
