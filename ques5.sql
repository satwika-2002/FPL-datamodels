## Question 5 (Multiple Aggregations)
--Generate a warehouse analytics report showing:
-- Total number of products
-- Average quantity per product
--Total inventory value
-- Maximum and minimum stock levels
--Number of distinct categories
--Group by warehouse location and only show warehouses with total inventory value > $50,000.

--Expected Output:

location    | product_count | avg_quantity | total_value | max_stock | min_stock | category_count
------------|--------------|--------------|-------------|-----------|-----------|---------------
Chicago, IL | 8            | 245.5        | 75890.50    | 500       | 125       | 4
Dallas, TX  | 7            | 232.1        | 68720.25    | 450       | 100       | 3


--solution query:
SELECT 
    w.location,
    COUNT(p.category) as product_count,
    AVG(i.quantity) as avg_quantity,
    sum(i.quantity * p.base_price) as total_value,
    max(i.quantity) as min_stock,
    min(i.quantity) as max_stock,
    COUNT(distinct p.category) as category_count
FROM 
    warehouses w
JOIN 
    inventory i ON w.warehouse_id = i.warehouse_id
JOIN 
    products p ON i.product_id = p.product_id
GROUP BY 
    w.location
having
	sum(i.quantity * p.base_price) > 50000;


--comments:
--1. The query selects the warehouse location, counts the number of products, calculates the average quantity per product, calculates the total inventory value, calculates the maximum and minimum stock levels, and counts the number of distinct categories.
--2. The query joins the warehouses, inventory, and products tables on the appropriate columns.
--3. The query groups the results by warehouse location.
--4. The HAVING clause filters the results to only show warehouses with a total inventory value greater than $50,000.
--group by is followed by having clause
