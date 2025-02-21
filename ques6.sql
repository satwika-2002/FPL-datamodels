## Question 6 (MERGE/UPSERT)
--Using this temporary table structure and data:

CREATE TEMP TABLE inventory_updates (
    product_id INT,
    warehouse_id INT,
    new_quantity INT
);

--INSERT INTO inventory_updates VALUES
(1, 1, 200),  -- Update existing
(21, 1, 100); -- Insert new
--Write a MERGE (UPSERT) query to update inventory quantities, inserting new records if they don't exist.

--solution query:
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

--dynamic query:
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

--comments:
--we are updating the values in inventory tables from new temporary table inventory_updates
--if the product_id and warehouse_id is already present in inventory table then we are updating the quantity
--if the product_id and warehouse_id is not present in inventory table then we are inserting the new record
--we are using dynamic query to update the inventory table
--we are using transaction to make sure that all the queries are executed successfully
--we can pass parameters to the procedure to update the inventory table
