--## Question 16 (Self Join)
--Find all pairs of products that:
- Are in the same category
- Have price difference < $20
- Are stocked in same warehouse
--List them as potential substitute products.

--Expected Output:

category    | product1     | price1 | product2     | price2 | warehouse
------------|-------------|---------|--------------|---------|----------
Electronics | Gaming Mouse | 59.99   | Keyboard    | 49.99   | Seattle
Sports      | Yoga Mat    | 29.99   | Water Bottle| 19.99   | Dallas

--solution query:
select p1.category as category,
p1.product_name as product1,
p1.base_price as price1,
p2.product_name as product2,
p2.base_price as price2,
w.location as warehouse from products p1
join
products p2
on p1.product_id < p2.product_id
and abs(p1.base_price - p2.base_price) < 20 and
p1.category = p2.category
join warehouses w on p1.product_id = w.product_id
group by w.location and p1.category
order by p1.category;

--comments:
-- The query uses a self join on the products table to find all pairs of products that are in the same category, have a price difference of less than $20 and are stocked in the same warehouse.
-- The query joins the products table with itself using the condition p1.product_id < p2.product_id to avoid duplicate pairs.
-- The query filters the pairs based on the price difference and category using the condition abs(p1.base_price - p2.base_price) < 20 and p1.category = p2.category.
-- The query then joins the result with the warehouses table to get the warehouse location for each pair of products.
-- The query groups the results by warehouse location and category and orders the results by category.
-- The query returns the category, product names, prices and warehouse location for each pair of products that meet the criteria.
-- The query uses the abs() function to calculate the absolute difference between the base prices of the two products.
-- The query uses the group by clause to group the results by warehouse location and category.