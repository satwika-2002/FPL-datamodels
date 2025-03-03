--CREATE TABLE Employees_linkedin2 (
employee_id INT PRIMARY KEY,
employee_name VARCHAR(255),
hire_date DATE,
manager_id INT 
);
--hashtag#Insert_data_into_the_Employees_table
--INSERT INTO Employees_linkedin2 (employee_id, employee_name, hire_date, manager_id) VALUES
(1, 'John Doe', '2023-01-15', NULL), 
(2, 'Jane Smith', '2023-02-20', 1),
(3, 'David Lee', '2023-03-10', 1),
(4, 'Sarah Jones', '2022-01-05', 2);
 
--Expected O/P:
janes smith
david lee

--solution query:
select e.employee_name 
from employees_linkedin2 e
join employees_linkedin2 e1 
on e.manager_id = e1.employee_id 
where e.hire_date > e1.hire_date;

--comments:
-- The query selects the employee_name from the employees_linkedin2 table where the hire_date of the employee is greater than the hire_date of their manager.
-- The query uses a self-join on the employees_linkedin2 table to compare the hire_date of each employee with the hire_date of their manager.
-- The join condition is based on the manager_id of the employee being equal to the employee_id of the manager.
-- The WHERE clause filters the results to only include employees whose hire_date is greater than their manager's hire_date.
-- The query returns the employee_name of the employees who meet the specified condition.