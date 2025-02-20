SELECT 'Zero Inventory' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products pLEFT JOIN inventory i ON p.product_id = i.product_idWHERE i.quantity IS NULl
UNION ALL
SELECT 'high stock' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity > 400
UNION ALL
SELECT 'high value' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity * p base_price > 10000;
#need more info about each and every column then it will be more easy totake columns and write query
#could't even understand many columns and their values
#need more difference in values