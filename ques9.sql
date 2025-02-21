CREATE FUNCTION calculate_inventory_metrics(warehouse_id INT)
RETURNS TABLE (
    total_products INT,
    total_value INT,
    avg_quantity DECIMAL(10,2),
    most_stocked_category VARCHAR(255)
) AS 
BEGIN
    RETURN QUERY
    SELECT 
        COUNT(p.product_id) as total_product,sum(i.quantity * p.base_price) as total_value,AVG(i.quantity) as avg_quantity,(select p.category FROM products p JOIN inventory i ON p.product_id = i.product_id GROUP BY p.category ORDER BY SUM(i.quantity) DESC) AS most_stocked_category
    FROM 
        products p
    JOIN 
        inventory i ON p.product_id = i.product_id
    join warehouses w on w.warehouse_id = i.warehouse_id = 1
END;
#