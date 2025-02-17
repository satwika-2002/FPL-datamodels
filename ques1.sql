select p.product_name,p.category,i.quantity from products p left join inventory i on p.product_id = i.inventory_id and i.warehouse_id = 1 order by i.quantity desc;