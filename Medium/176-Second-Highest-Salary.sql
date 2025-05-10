-- Problem: 176. Second Highest Salary
-- Difficulty: Easy
-- Link: https://leetcode.com/problems/second-highest-salary/
--
-- Explanation:
-- We assign a rank to each unique salary using DENSE_RANK().
-- Then we select the salary with rank 2, which is the second highest.
-- LIMIT 1 ensures the query returns a single value, even if multiple salaries share the rank.

select(
    select salary from(
        select salary,
        dense_rank() over(order by salary desc) as rnk
        from Employee
    ) x
where x.rnk = 2
limit 1) as SecondHighestSalary