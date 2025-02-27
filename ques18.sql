--## Question 18 (Role-Based Access Control)
--Create a permission structure for an inventory management system with these roles:
- Inventory Manager: Full access to all tables
- Stock Clerk: Can view all tables, update inventory quantities
- Analyst: Can only view (SELECT) all tables
- Auditor: Can only view inventory and audit_log tables

--Expected Output after running GRANT commands:

Role              | Select | Insert | Update | Delete | References | Trigger
------------------|---------|---------|---------|---------|------------|----------
inventory_manager | Yes    | Yes    | Yes    | Yes    | Yes       | Yes
stock_clerk      | Yes    | No     | Partial| No     | No        | No
analyst          | Yes    | No     | No     | No     | No        | No
auditor          | Partial| No     | No     | No     | No        | No


create role 'inventory_manager';
create role 'stock_clerk';
create role 'analyst';
create role 'auditor';
grant all privileges on inventory.* to 'inventory_manager';
grant select on inventory.* to 'stock_clerk';
grant select on products.* to 'stock_clerk';
grant select on warehouses.* to 'stock_clerk';
grant select on suppliers.* to 'stock_clerk';
grant update on inventory.quantity to 'stock_clerk';
grant select on inventory.* to 'analyst';
grant select on products.* to 'analyst';
grant select on warehouses.* to 'analyst';
grant select on suppliers.* to 'analyst';
grant select on inventory.* to 'auditor';
grant select on audit_log.* to 'auditor';

select (case when privilege_type = 'select' then 'yes' else 'no' end) as select,
(case when privilege_type = 'insert' then 'yes' else 'no' end) as insert,
(case when privilege_type = 'update' then 'yes' else 'no' end) as update,
(case when privilege_type = 'delete' then 'yes' else 'no' end) as delete;

--comments:
--we create four roles: inventory_manager, stock_clerk, analyst, and auditor
--we grant all privileges on the inventory table to the inventory_manager role
--we grant select privileges on the inventory table to the stock_clerk role and update privileges on the inventory.quantity column to the stock_clerk role
--we grant select privileges on the products, warehouses, and suppliers tables to the stock_clerk role
--we grant select privileges on the inventory table to the analyst role
--we grant select privileges on the products, warehouses, and suppliers tables to the analyst role
--we grant select privileges on the inventory and audit_log tables to the auditor role
--we use the grant command to assign privileges to each role
--we use the select statement to display the privileges granted to each role
--the output shows the privileges granted to each role for select, insert, update, and delete operations
--the output also shows 'yes' for the privileges granted and 'no' for the privileges not granted
