## Question 7 (Complex GROUP BY with conditions)
--Find product categories where:
- Average inventory value > $10,000
- At least 3 different products in stock
- Maximum quantity of any product > 200
--Show category, product count, avg value, and highest stocked product name.

--Expected Output:
category    | product_count | avg_value | highest_stocked_product
------------|--------------|-----------|----------------------
Electronics | 5            | 12500.75  | Gaming Mouse
Sports      | 4            | 11200.50  | Yoga Mat

--solution query:
SELECT p.category,COUNT(distinct p.product_id) AS product_count,AVG(i.quantity * p.base_price) AS avg_value,(select p1.product_name from products p1 join inventory i1 on i1.product_id = p1.product_id where p.category = p1.category order by i1.quantity desc limit 1) as highest_stocked_product FROM products p JOIN inventory i ON p.product_id = i.product_id GROUP BY p.category having AVG(i.quantity * p.base_price) > 10000 AND COUNT(DISTINCT p.product_id) >= 3 AND max(i.quantity) > 200;

--comments:
--1. The query selects the category, product count, average value, and highest stocked product name.
--2. The query joins the products and inventory tables on the product_id column.
--3. The query groups the result by the category column.
--4. The HAVING clause filters the results based on the conditions average inventory value > $10,000, at least 3 different products in stock, and maximum quantity of any product > 200.
--5. The subquery is used to get the highest stocked product name for each category.
--6. the subquery selects the product_name from the products table where the category matches the outer query category, orders the result by quantity in descending order, and limits the result to 1 row.
