SELECT 'Zero Inventory' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products pLEFT JOIN inventory i ON p.product_id = i.product_idWHERE i.quantity IS NULl
UNION
SELECT 'high stock' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity > 400
UNION
SELECT 'high value' AS source_category,p.product_name,i.quantity,(i.quantity * p.base_price) as value FROM products p JOIN inventory i ON p.product_id = i.product_id WHERE i.quantity * p base_price > 10000;
SELECT 
    p.product_name,
    i.quantity,
    (p.base_price * i.quantity) AS total_value,
    CASE 
        WHEN i.quantity IS NULL THEN 'no stock'
        WHEN i.quantity > 400 THEN 'high stock'
        WHEN (p.base_price * i.quantity) > 10000 THEN 'high value'
    END AS source_category
FROM 
    products p
LEFT JOIN 
    inventory i ON p.product_id = i.product_id
WHERE 
    i.quantity IS NULL 
    or i.quantity > 400 
    or p.base_price * i.quantity > 10000;
#need more info about each and every column then it will be more easy totake columns and write query
#could't even understand many columns and their values
#need more difference in values