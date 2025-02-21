SELECT 
        p.category,
        COUNT(p.product_id) AS product_count,
        AVG(i.quantity * p.base_price) AS avg_value,
        MAX(i.quantity) AS max_quantity,
        p.product_name as highest_stocked_product
    FROM 
        products p
    JOIN 
        inventory i ON p.product_id = i.product_id
    GROUP BY 
        p.category
    having
    	AVG(i.quantity * p.base_price) > 10000
    	AND product_count >= 3
    	AND max_quantity > 200;