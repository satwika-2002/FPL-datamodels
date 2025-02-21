--question2:
--List all warehouses that store electronics products, along with the total quantity and total value of electronics inventory (quantity * base_price). Only include warehouses with electronics inventory worth over $20,000. Order by total value descending.

--Expected Output:
location    | total_quantity | total_value
------------|---------------|-------------
Seattle, WA | 350           | 31497.50
Boston, MA  | 365           | 25696.35
Chicago, IL | 275           | 21997.25

--solution query:
select w.location,i.quantity,sum(i.quantity * p.base_price) as total_value from warehouses w inner join inventory i on w.warehouse_id = i.warehouse_id inner join products p on p.product_id = i.product_id
where p.category = 'Electronics' and sum(i.quantity * p.base_price) > 20000
order by total_value desc;

--comments:
--1. The query joins the warehouses, inventory, and products tables on the respective columns.
--2. It filters the rows where the product category is 'Electronics' and the total value of the inventory is greater than $20,000.
--3. The query calculates the total value of the electronics inventory by multiplying the quantity with the base price of the product.
--4. The result is ordered by the total value in descending order.
--5. The output includes the warehouse location, total quantity of electronics inventory, and total value of electronics inventory.
--inner join is used to join the tables based on the common columns.here warehouses,inventory and products tables are joined based on the warehouse_id,product_id columns.