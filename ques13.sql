--## Question 13 (LEAD/LAG Analysis)
--Analyze inventory changes by comparing:
- Current quantity with previous month
- Current quantity with next month
- Percentage change from previous
- Projected next month change
--For each product in a specific warehouse.

--Expected Output:

product_name    | current_qty | prev_month_qty | next_month_qty | pct_change | projected_change
----------------|-------------|----------------|----------------|------------|------------------
Wireless Earbuds| 150         | 120            | 180            | +25%       | +20%
Gaming Mouse    | 200         | 180            | 220            | +11%       | +10%
Smart Watch     | 175         | NULL           | 160            | NULL       | -8.5%


--solution query:
with quan as (select p.product_name,
i.quantity as cut_quantity,
lead(i.quantity,1) over(partition by p.product_id order by i.last_updated) as next_quantity,
lag(i.quantity,1) over(partition by p.product_id order by i.last_updated) as prev_quantity from products p join inventory i on p.product_id = i.product_id order by p.product_id)
select q.product_name,
q.cut_quantity,
q.next_quantity,
q.prev_quantity,
(((q.cut_quantity-q.prev_quantity) / (q.prev_quantity)) * 100)||'%' as pct_change,
(((q.next_quantity-q.cut_quantity) / (q.cut_quantity)) * 100)||'%' as projected_change
from quan q;

--comments:
--we use the with clause to create a common table expression (CTE) named quan
--we select the product_name, current quantity, next month quantity, and previous month quantity from the products and inventory tables
--we use the lead and lag functions to get the next and previous month quantities for each product
--we partition the data by product_id and order it by last_updated
--we calculate the percentage change from the previous month and the projected change for the next month
--we use the select statement to display the product_name, current quantity, next month quantity, previous month quantity, percentage change, and projected change
--the output shows the product_name, current quantity, next month quantity, previous month quantity, percentage change, and projected change for each product
--the pct_change column shows the percentage change from the previous month
--the projected_change column shows the projected change for the next month
