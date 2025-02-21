## Question 9 (Function)
--Create a function called `calculate_inventory_metrics` that takes a warehouse_id as input and returns a record containing:
- Total number of products
- Total inventory value
- Average quantity per product
- Most stocked category
--For the given warehouse.

--Call the function for warehouse_id = 1.

--Expected Output:
total_products | total_value | avg_quantity | most_stocked_category
---------------|-------------|--------------|--------------------
12             | 45678.50    | 245.5        | Electronics

--solutoin query:
CREATE FUNCTION calculate_inventory_metrics(warehouse_id INT) --the function will return a table on specified format
RETURNS TABLE (
    total_products INT,
    total_value INT,
    avg_quantity DECIMAL(10,2),
    most_stocked_category VARCHAR(255)
) AS 
BEGIN
    RETURN QUERY --Executes the specified SQL query and returns its result set directly.
    SELECT 
        COUNT(p.product_id) as total_product,sum(i.quantity * p.base_price) as total_value,AVG(i.quantity) as avg_quantity,(select p.category FROM products p JOIN inventory i ON p.product_id = i.product_id join warehouses w i.warehouse_id = w.warehouse_id = 1 GROUP BY p.category ORDER BY SUM(i.quantity) DESC) AS most_stocked_category
    FROM 
        products p
    JOIN 
        inventory i ON p.product_id = i.product_id
    join warehouses w on w.warehouse_id = i.warehouse_id
    WHERE 
        i.warehouse_id = warehouse_id;
END;
#select * from calculate_inventory_metrics(1); -- to call the function using warehouse_id =1

--comments:
-- The function calculate_inventory_metrics takes a warehouse_id as input and returns a record containing the total number of products, total inventory value, average quantity per product, and most stocked category for the given warehouse.
-- The function uses a RETURN QUERY statement to execute a SELECT query that calculates the required metrics based on the input warehouse_id.
-- The SELECT query joins the products, inventory, and warehouses tables to retrieve the necessary data for the calculation.
-- The function returns the calculated metrics as a table with the specified column names and data types.
--the where clause is used to filter the data based on the input warehouse_id.