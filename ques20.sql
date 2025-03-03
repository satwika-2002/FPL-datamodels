-- just try this one if possible:
 
-- for the same data, try to write a Recursive query. Create a new column, that shows how many managers were there above him.
-- For eg:
-- for employee_id 4: he has 2 managers above him (employee_id: 2 and 1)
-- for employee_id: 2 and 3, has only 1 manager (employee_id: 1)
-- for employee_id:1, he is the manager (He reports to no one as his manager_id is null)
 
with recursive m_count as(
  select employee_id,employee_name,hire_date,manager_id, 0 as hierarchy 
  from employees_linkedin2 
  where manager_id = 0
  union all
select e.employee_id,e.employee_name,e.hire_date,e.manager_id, m.hierarchy +1
  from employees_linkedin2 e
  join m_count m on e.manager_id = m.employee_id)
select * from m_count;

--comments:
--we use the with recursive clause to create a recursive query
--we define a common table expression (CTE) named m_count
--we select the employee_id, employee_name, hire_date, manager_id, and 0 as hierarchy from the employees_linkedin2 table where the manager_id is 0
--we use the union all operator to combine the results of the base query and the recursive query
--in the recursive query, we select the employee_id, employee_name, hire_date, manager_id, and m.hierarchy + 1 from the employees_linkedin2 table
