-- Problem: 181. Employees Earning More Than Their Managers
-- Difficulty: Easy
-- Link: https://leetcode.com/problems/employees-earning-more-than-their-managers/
--
-- Explanation:
-- We join the Employee table to itself using managerId.
-- Then we compare each employee's salary to their manager's salary.
-- If the employee's salary is greater, we return their name.

select e.name as Employee
from Employee e
join Employee m on e.managerId = m.id
where e.salary > m.salary