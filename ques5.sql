SELECT 
    w.location,
    COUNT(p.category) as product_count,
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
#didn't understand product count(based on id or name)
#performed different aggregate functions on columns of different tables
#used joins coz there is relation b/w tables and we calculated one value based on relation