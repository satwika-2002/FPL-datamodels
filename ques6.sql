CREATE TEMP TABLE inventory_updates (
    product_id INT,
    warehouse_id INT,
    new_quantity INT
);
--insert statement that check weather data is already present or not
insert into inventory_updates(product_id,warehouse_id,new_quantity)
select 1,1,200
where not exists(select 1 from inventory_updates where product_id = 1 and warehouse_id = 1);
--update statement 
update inventory_updates 
set new_quantity = 300
where exists(select 1 from inventory_updates where product_id = 1 and warehouse_id = 1);

--dynamic query to check the data
CREATE PROCEDURE UpdateInventoryFromTemp
AS
BEGIN
    BEGIN TRANSACTION;

    -- Update existing records
    UPDATE inventory
    SET quantity = iu.new_quantity
    FROM inventory_updates iu
    WHERE inventory.product_id = iu.product_id
    AND inventory.warehouse_id = iu.warehouse_id
    AND EXISTS (
        SELECT 1 
        FROM inventory 
        WHERE product_id = iu.product_id 
        AND warehouse_id = iu.warehouse_id
    );

    -- Insert new records
    INSERT INTO inventory (product_id, warehouse_id, quantity)
    SELECT iu.product_id, iu.warehouse_id, iu.new_quantity
    FROM inventory_updates iu
    WHERE NOT EXISTS (
        SELECT 1 
        FROM inventory 
        WHERE product_id = iu.product_id 
        AND warehouse_id = iu.warehouse_id
    );
    COMMIT;
END;
--when ever we want to update the inventory we can call this procedure
EXEC UpdateInventoryFromTemp;