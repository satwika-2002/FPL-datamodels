select w.location,i.quantity,sum(i.quantity * p.base_price) as total_value from warehouses w inner join inventory i on w.warehouse_id = i.warehouse_id inner join products p on p.product_id = i.product_id
where p.category = 'Electronics' and sum(i.quantity * p.base_price) > 20000
order by total_value desc;
#create a new column that contain value
#listed only warehouses that contain electronics whose value is greater than 20000
#order by total value in descending order 