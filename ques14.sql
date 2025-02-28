--## Question 14 (Single-Row and Multi-Row Subqueries)
--Find products that meet ALL these conditions:
- Price higher than average category price (single-row subquery)
- Stocked in warehouses with >80% capacity utilization (multi-row subquery)
- Total inventory value higher than any Sports category product (multi-row subquery)

--Expected Output:

product_name    | category    | price  | total_value | warehouses
----------------|------------|--------|-------------|------------
Gaming Mouse    | Electronics| 199.99 | 45000.50   | Seattle, Dallas
Smart Watch     | Electronics| 159.99 | 42500.75   | Chicago, Boston

-- Query:
select p.product_name,
p.category,
p.base_price,
w.location,
(p.base_price * i.quantity) as total_value
from products p
join
inventory i on i.product_id = p.product_id
join
warehouses w on i.warehouse_id = w.warehouse_id
where p.base_price > (select avg(p1.base_price) from products p1 group by p1.category having p.category = p1.category)
and w.location in (select w1.location from warehouses w1 join inventory i1 on w1.warehouse_id = i1.warehouse_id group by w1.location having sum(i1.quantity) > 0.8 * w1.capacity)
and (p.base_price * i.quantity) > (select max(p1.base_price * i1.quantity) as value from products p1 join inventory i1 on p1.product_id = i1.product_id where p1.category = 'Sports');

--comments:
--the query deals with single and multiple line queries
--the query uses the subquery to find the average price of the product in the category
--the first sub query deals with the price of the product as the price of the product should be greater than the average price of the product in the category
--the second sub query deals with the warehouse location and the capacity of the warehouse as the warehouse should have more than 80% capacity
--the third sub query deals with the total value of the product in the inventory as the total value of the product should be greater than the maximum value of the product in the sports category
--the query uses the join to join the product, inventory, and warehouse table
--the query uses the where clause to filter the data based on the condition
