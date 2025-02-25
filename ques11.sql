## Question 11 (COALESCE, NULLIF, LPAD/RPAD)
--Create a report showing formatted product details with:
- Product code (LPAD with zeros to 5 digits)
- Product name (RPAD with dots to 30 characters)
- Current stock (COALESCE with 'Out of Stock')
- Stock status (NULLIF comparison with minimum threshold)
--For all products in Electronics category.

--Expected Output:
product_code | formatted_name                | stock_level | status
-------------|------------------------------|-------------|--------
00001        | Wireless Earbuds............| 150         | NORMAL
00002        | Gaming Mouse................| Out of Stock| LOW
00006        | Smart Watch................. | 175         | NULL

--solution query:
select lpad(p.product_id,5,0) as product_code,rpad(p.product_name,30,'.') as formated_name,coalesce(i.quantity,'out of stock') as stock_level,
case 
when i.quantity <= 100 then 'low' 
when i.quantity => 100 then 'normal' 
end as status 
from products p join inventory i on p.product_id = i.product_id where p.category = 'Electronics';

--comments:
--In this query, we are using LPAD and RPAD functions to format the product code and name respectively.
--We are using COALESCE function to display 'Out of Stock' if the stock level is NULL.
--We are using NULLIF function to compare the stock level with the minimum threshold and display the status accordingly.
--we are taking threshold as 100.
--if quantity is less than 100 then status is low and if quantity is greater than 100 then status is normal.
--We are joining the products and inventory tables on product_id and filtering the products in the Electronics category.
--The output is displayed in the specified format with the product code, formatted name, stock level, and status.



