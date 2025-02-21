SELECT 
        p.category,
        COUNT(distinct p.product_id) AS product_count,
        AVG(i.quantity * p.base_price) AS avg_value,
        (select p1.product_name from products p1 join inventory i1 on i1.product_id = p1.product_id where p.category = p1.category order by i1.quantity desc limit 1) as highest_stocked_product
    FROM 
        products p
    JOIN 
        inventory i ON p.product_id = i.product_id
    GROUP BY 
        p.category
    having
    	AVG(i.quantity * p.base_price) > 10000
    	AND COUNT(DISTINCT p.product_id) >= 3
    	AND max(i.quantity) > 200;