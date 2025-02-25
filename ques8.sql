## Question 8 (UNION and UNION ALL)
--Create a report showing:
1. Products with zero inventory (from LEFT JOIN)
2. Products with over 400 units in any warehouse
3. Products with value over $10,000 in any warehouse
Label each row with its source category.

--Expected Output:
source_category | product_name    | quantity | value
----------------|----------------|----------|-------
No Stock        | Smart Watch    | 0        | 0.00
High Stock      | Backpack       | 450      | 22495.50
High Value      | Gaming Mouse   | 350      | 20996.50

--using union all:
SELECT 'Zero Inventory' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p LEFT JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity IS NUll
UNION
SELECT 'high stock' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity > 400
UNION
SELECT 'high value' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity * p.base_price > 10000;

--using case statement:
SELECT 
    p.product_name,
    i.quantity,
    (p.base_price * i.quantity) AS total_value,
    CASE 
        WHEN i.quantity IS NULL THEN 'no stock'
        WHEN i.quantity > 400 THEN 'high stock'
        WHEN (p.base_price * i.quantity) > 10000 THEN 'high value'
    END AS source_category FROM products p LEFT JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity IS NULL or i.quantity > 400 or p.base_price * i.quantity > 10000;

--comments:
-- The UNION operator is used to combine the result-set of two or more SELECT statements.
-- The UNION operator selects only distinct values by default. To allow duplicate values, use UNION ALL.
-- we are checking for products with zero inventory, products with over 400 units in any warehouse, and products with value over $10,000 in any warehouse.
-- we are using the LEFT JOIN to get products with zero inventory.
--we are using left join to get all the products from the products table and only the products that have inventory in the inventory table.
-- we are using the JOIN to get products with over 400 units in any warehouse and products with value over $10,000 in any warehouse.
-- we are using the CASE statement to label each row with its source category.
-- The CASE statement goes through conditions and returns a value when the first condition is met (like an IF-THEN-ELSE statement).
-- The CASE statement is followed by at least one pair of WHEN and THEN statements. ELSE is an optional statement.
