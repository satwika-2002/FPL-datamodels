## Question 10 (Stored Procedure)
C--reate a stored procedure called `transfer_inventory` that:
- Takes source_warehouse_id, target_warehouse_id, product_id, and quantity as parameters
- Transfers specified quantity from source to target warehouse
- Includes error handling for insufficient stock
- Logs the transfer in a new audit_log table
- Returns success/failure message

--Test the procedure with:
- Success case: Transfer 50 units of product_id 1 from warehouse 1 to warehouse 2
- Failure case: Try to transfer 1000 units (more than available)

--create a audit table to store the logs of the transfer
CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    source_warehouse_id INT,
    target_warehouse_id INT,
    product_id INT,
    quantity INT,
    status VARCHAR(20),
    transfer_time timestamp default CURRENT_TIMESTAMP
);

--create a stored procedure to transfer inventory
CREATE PROCEDURE transfer_inventory(
    IN source_warehouse_id INT,
    IN target_warehouse_id INT,
    IN product_id INT,
    IN quantity INT
)
BEGIN
    DECLARE available_quantity INT;
    DECLARE transfer_message VARCHAR(255);

    SELECT quantity INTO available_quantity
    FROM inventory
    WHERE warehouse_id = source_warehouse_id AND product_id = product_id;

    -- Error handling for insufficient stock
    IF available_quantity is null or available_quantity < quantity THEN
        SET transfer_message = 'Failure: Insufficient stock in source warehouse';
        -- Log the transfer
        INSERT INTO audit_log (source_warehouse_id, target_warehouse_id, product_id, quantity, status)
        VALUES (source_warehouse_id, target_warehouse_id, product_id, quantity, transfer_status);
    ELSE
        -- Deduct quantity from source warehouse
        UPDATE inventory
        SET available_quantity = available_quantity - quantity
        WHERE warehouse_id = source_warehouse_id AND product_id = product_id;

        -- Add quantity to target warehouse
        INSERT INTO inventory (warehouse_id, product_id, quantity)
        VALUES (target_warehouse_id, product_id, quantity)
        ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity); --we use duplicate key update cause insert statement will result error on duplicate key(warehouse_id, product_id), we will update the values to new values without error 

        -- Log the transfer
        SET transfer_message = 'Success: Inventory transferred successfully';
        INSERT INTO audit_log (source_warehouse_id, target_warehouse_id, product_id, quantity, status)
        VALUES (source_warehouse_id, target_warehouse_id, product_id, quantity, transfer_status);
    END IF;
END;

--comments:
-- The stored procedure `transfer_inventory` is created to transfer inventory between warehouses.
-- It includes error handling for insufficient stock and logs the transfer in the `audit_log` table.
-- The procedure is tested with success and failure cases to transfer inventory between warehouses.
--printing the message for success and failure cases
--using if else to check the status of the transfer
--if the available quantity is less than or null the quantity to be transferred then it will print the message as 'Failure: Insufficient stock in source warehouse'
--else it will transfer the quantity from source to target warehouse and print the message as 'Success: Inventory transferred successfully'
--updating the inventory table with the new quantity after the transfer
