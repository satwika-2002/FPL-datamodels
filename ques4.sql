## Question 4 (CROSS JOIN)
--Generate a report showing all possible product-warehouse combinations for 'Sports' category products and 'Large' type warehouses to help with expansion planning. Show product name, warehouse location, and warehouse capacity.

--Expected Output:
product_name  | location    | capacity
-------------|-------------|----------
Yoga Mat     | Dallas, TX  | 15000
Yoga Mat     | Chicago, IL | 20000
Yoga Mat     | Houston, TX | 16000
Running Shoes| Dallas, TX  | 15000
[...all combinations...]

--solution query:
select p.product_name,w.location,w.capacity from warehouses w cross join products p where p.category = 'Sports' and w.warehouse_type = 'Large';

--comments:
--cross join is used to get all possible combinations of two tables
--here we are getting all possible combinations of products with category 'Sports' and warehouses with type 'Large'
--we are selecting product name, warehouse location, and warehouse capacity
--we are using cross join to get all possible combinations of products and warehouses
