SELECT 
    w.location,
    COUNT(p.product_id) as product_count,
    AVG(i.quantity) as avg_quantity,
    sum(i.quantity * p.base_price) as total_value,
    max(i.quantity) as min_stock,
    min(i.quantity) as max_stock,
    COUNT(distinct p.category) as category_count
FROM 
    warehouses w
JOIN 
    inventory i ON w.warehouse_id = i.warehouse_id
JOIN 
    products p ON i.product_id = p.product_id
GROUP BY 
    w.location
having
	sum(i.quantity * p.base_price) > 50000;