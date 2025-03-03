--## Question 17 (FIRST_VALUE, LAST_VALUE, NTILE)
--Analyze product performance by:
- First and last products sold in each category
- Product price quartiles within category
- Comparison with category boundaries

--Expected Output:

category    | product_name | price | first_sold | last_sold | quartile | price_range
------------|-------------|-------|------------|-----------|----------|-------------
Electronics | Smart Watch | 199.99| Earbuds    | Keyboard  | 4        | High
Sports      | Yoga Mat    | 29.99 | Shoes      | Weights   | 2        | Medium-Low

--solution query:
with quart as ( select p.base_price as price, p.category as category,
first_value(p.product_name) over(partition by p.category order by i.last_updated asc rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) as first_sold,
last_value(p.product_name) over(partition by p.category order by i.last_updated rows BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING ) as last_sold,
ntile(4) over(partition by p.category order by p.base_price asc) as quartile
from products p join inventory i on p.product_id = i.product_id)
select q.category,
q.price,
q.first_sold,
q.last_sold,
q.quartile,
case when q.quartile = 4 then 'high'
when q.quartile = 3 then 'mid-high'
when q.quartile = 2 then 'mid-low'
when q.quartile = 1 then 'low'
end as price_range
from quart q
order by q.category;

--comments:
--the query uses the first_value and last_value functions to get the first and last products sold in each category
--the ntile function is used to get the quartile of the product price within each category
--the ntile function divides the data into 4 equal parts based on the price of the product
--the case statement is used to assign a price range to each quartile based on the category boundaries as low, mid-low, mid-high, and high
--the query then selects the category, product price, first and last products sold, quartile, and price range for each category
--the results are ordered by category
--we use with clause to create a common table expression (CTE) named quart to calculate the quartile of the product price within each category





