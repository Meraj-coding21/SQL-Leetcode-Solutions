-- Problem: 177. Nth Highest Salary
-- Difficulty: Medium
-- Link: https://leetcode.com/problems/nth-highest-salary/
-- 
-- Explanation:
-- We assign a rank to each unique salary using DENSE_RANK() in descending order.
-- Then we filter to return the salary at the N-th rank.
-- LIMIT 1 ensures the function returns a single value even if multiple rows share that rank.

CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      select salary from
            (select salary,
            dense_rank() over(order by salary desc) as rnk
            from Employee) x
      where x.rnk = N
      limit 1;
  );
END;
  
