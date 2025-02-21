select p.product_name,p.category,i.quantity,w.location from products p left join inventory i on p.product_id = i.product_id and i.warehouse_id = 1 left join warehouses w on w.warehouse_id = 1 order by i.quantity desc;
# the question collects the data from products,inventory and warehouse TABLES
#inventory table is holding foreign keys REFERENCES
# we will join the tables by checking/equating the id's from these tables
# what if invetory table is holding only one table id?