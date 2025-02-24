## Question 3 (SEMI JOIN)
--Find all suppliers who supply products that have current inventory levels below 100 units in any warehouse. Show supplier name, country, and reliability score. Order by reliability score descending.

--Expected Output:
supplier_name      | country     | reliability_score
------------------|-------------|------------------
FitLife Supplies  | USA         | 4.90
TechPro Solutions | USA         | 4.80
SmartHome Devices | South Korea | 4.50

--solution query:
select s.supplier_name,s.country,s.reliability_score from suppliers s where
exists(select 1 from suppliers s join inventory i on i.supplier_id = s.supplier_id where i.quantity < 100)
order by s.reliability_score desc;

--comments:
--1. The query uses a subquery in the WHERE clause to check if there are any products with inventory levels below 100 units.
--2. The EXISTS keyword is used to filter the suppliers based on the subquery result.
--3. The output columns supplier_name, country, and reliability_score are selected from the suppliers table.
--4. The result is ordered by reliability_score in descending order.
--5. This query retrieves the required information about suppliers who supply products with low inventory levels.
--6.semi join is used to filter the suppliers based on the condition specified in the subquery.
--7.it will check the extstence of the products with inventory levels below 100 units in any warehouse.
--8.it doesn't return duplicate rows and rows from second table.