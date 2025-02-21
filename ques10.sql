CREATE TABLE audit_log (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    source_warehouse_id INT,
    target_warehouse_id INT,
    product_id INT,
    quantity INT,
    status VARCHAR(20),
    transfer_time timestamp default CURRENT_TIMESTAMP
);
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
        ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity);

        SET transfer_message = 'Success: Inventory transferred successfully';
        INSERT INTO audit_log (source_warehouse_id, target_warehouse_id, product_id, quantity, status)
        VALUES (source_warehouse_id, target_warehouse_id, product_id, quantity, transfer_status);
    END IF;
END;