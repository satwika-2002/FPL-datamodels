## Question 1 (LEFT JOIN)
--Find all products and their current inventory levels in Seattle warehouse (warehouse_id = 1), including products with no inventory. Display product name, category, and quantity. Order by quantity descending, with NULLs last.

--Expected Output:
--product_name        | category    | quantity
-------------------|-------------|----------
Gaming Mouse       | Electronics | 200
Wireless Earbuds   | Electronics | 150
Tennis Racket      | Sports      | NULL
Smart Watch        | Electronics | NULL
[...remaining products with NULL quantities...]

--solution query:
select p.product_name,p.category,i.quantity,w.location from products p left join inventory i on p.product_id = i.product_id and i.warehouse_id = 1 left join warehouses w on w.warehouse_id = 1 order by i.quantity desc nulls last;
comments:
--the question collects the data from products,inventory and warehouse TABLES
--inventory table is holding foreign keys REFERENCES from products and warehouse tables
--we are using left join to get all the products and their inventory levels in Seattle warehouse
--first we are joining the products and inventory tables on product_id
--then we are joining the inventory and warehouse tables on warehouse_id
--we are using warehouse_id = 1 to get the data of Seattle warehouse
--we are using order by to sort the data in descending order of quantity
--we are using nulls last to display the products with no inventory at the end
--we are selecting the product_name,category,quantity and location from the respective tables