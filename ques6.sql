CREATE TEMP TABLE inventory_updates (
    product_id INT,
    warehouse_id INT,
    new_quantity INT
);
--insert statement that check weather data is already present or not
insert into inventory_updates(product_id,warehouse_id,new_quantity)
select 1,1,200
where not exists(select 1 from inventory_updates where product_id and warehouse_id = 1);
--update statement 
update inventory_updates
set new_quantity = 300
where exists(select 1 from inventory_updates where product_id and warehouse_id = 1);
