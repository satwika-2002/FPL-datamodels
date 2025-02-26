--## Question 15 (RANK, DENSE_RANK, ROW_NUMBER)
--Create a warehouse performance report showing:
- Regular ranking by total inventory value
- Dense ranking by number of products
- Row number by average quantity
--Include only warehouses handling >5 products.

--Expected Output:

warehouse    | total_value | value_rank | products | product_rank | avg_qty | qty_rn
-------------|-------------|------------|----------|--------------|---------|--------
Chicago      | 120500.75  | 1          | 12       | 1            | 245     | 3
Dallas       | 120500.75  | 1          | 10       | 2            | 300     | 1
Seattle      | 98750.50   | 3          | 10       | 2            | 280     | 2

--solution query:
with value1 as (
  select p.category, i.quantity, w.location, (p.base_price * i.quantity) as value,(count(distinct p.product_id)) as product_count 
  from products p
  join inventory i on i.product_id = p.product_id 
  join warehouses w on w.warehouse_id = i.warehouse_id 
group by w.location)
select v.location as warehouse, 
v.product_count,
sum(v.value) as total_value,
(rank() over(order by sum(v.value) desc)) as value_rank,v.product_count,
(dense_rank() over(order by v.product_count desc)) as product_rank, 
avg(v.quantity) as avg_quantity, 
(row_number() over(order by avg(v.quantity) desc)) as qty_rn 
from value1 v 
where  v.product_count >= 1 and (v.location != null or trim(v.location) != '');

--comments:
-- The query uses the rank(), dense_rank() and row_number() window functions to rank the warehouses based on total inventory value, number of products and average quantity respectively.
-- The query uses the with clause to create a common table expression (CTE) named value1 that calculates the total inventory value, product count and average quantity for each warehouse.
-- what are the columns that we used result query are specefied in the output table.
-- The query filters out warehouses that handle less than 1 product and have a null or empty location.
-- The query groups the results by warehouse and calculates the total inventory value, product count and average quantity for each warehouse.
-- The query then ranks the warehouses based on total inventory value, number of products and average quantity using the rank(), dense_rank() and row_number() window functions respectively.
-- The query returns the warehouse location, total inventory value, value rank, product count, product rank, average quantity and quantity rank for each warehouse.
--we use with clause to ease the readability of the query and to avoid repeating the same subquery multiple times.
