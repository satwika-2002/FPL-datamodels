--Generate a monthly sales trend analysis showing:
- Running total of inventory value
- Running average of quantity
- Percentage of total inventory
--Ordered by warehouse location and product category.

--Expected Output:
location    | category    | quantity | running_total | running_avg | pct_of_total
------------|------------|----------|---------------|-------------|-------------
Chicago, IL | Electronics| 250      | 12500.00      | 250.00      | 15.5
Chicago, IL | Sports     | 300      | 27500.00      | 275.00      | 28.3
Dallas, TX  | Electronics| 200      | 37500.00      | 250.00      | 35.8

--solution query:
with value1 as (select p.category, i.quantity, w.location, (p.base_price * i.quantity) as value from products p join inventory i on i.product_id = p.product_id join warehouses w on w.warehouse_id = i.warehouse_id)
select v.location,
v.category,
v.quantity,
round(sum(v.value) over (order by v.location and v.category),2) as running_row,
floor(avg(v.quantity) over (order by v.location and v.category)) as running_avg,
round((100 * v.value/sum(v.value) over()),2) as pct_of_total 
from value1 v
order by v.location and v.category;

--comments:
--In this query, we are calculating the value of the inventory by multiplying the base price of the product with the quantity in stock.
--We are using a common table expression (CTE) to calculate the value of the inventory for each product category in each warehouse location.
--We are then using window functions to calculate the running total of the inventory value, running average of the quantity, and percentage of the total inventory value.
--The running total is calculated using the sum() window function over the location and category.
--The running average is calculated using the avg() window function over the location and category.
--we are using with clause to create a temporary table value1 which contains the category, quantity, location, and value of the inventory.
--so that we can use this temporary table in the main query to calculate the running total, running average, and percentage of the total inventory.
--The output is displayed in the specified format with the location, category, quantity, running total, running average, and percentage of the total inventory.
--The results are ordered by warehouse location and product category.