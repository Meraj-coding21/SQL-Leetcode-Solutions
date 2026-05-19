# SQL LeetCode Solutions

A complete collection of my solutions for the [LeetCode Top SQL 50](https://leetcode.com/studyplan/top-sql-50/) study plan, organized by difficulty.

This isn't a polished answer key — it's a personal record of how I actually worked through these problems. Some solutions are clean and optimal. Others are not, and I've noted that where it's the case. The goal was to solve every problem, document my thinking, and build a reference I can come back to.

---

## Progress

| Difficulty | Solved |
|---|---|
| Easy | 33 |
| Medium | 20 |
| Hard | 1 |
| **Total** | **54** |

---

## Structure

```
SQL-Leetcode-Solutions/
├── Easy/
├── Medium/
└── Hard/
```

Solutions are written in **MySQL** or **PostgreSQL** depending on what the problem required — the dialect is noted at the top of files where it matters.

---

## Patterns Encountered

Working through these problems back to back makes patterns emerge that you don't necessarily notice when solving problems in isolation. Here's what came up repeatedly across the 54 solutions.

---

### Window Functions

The most frequently used tool across this set. `DENSE_RANK()` appears in at least 5 problems — ranking scores, finding the Nth highest salary, top salaries per department, and first-year product sales. `LAG()` and `LEAD()` handle row-to-row comparisons without a self-join (Rising Temperature, Consecutive Numbers). `SUM() OVER(ORDER BY ...)` was the key to the running total in the bus capacity problem.

```sql
-- 180. Consecutive Numbers
SELECT DISTINCT num AS ConsecutiveNums FROM (
  SELECT num,
    LEAD(num) OVER() AS higherNum,
    LAG(num) OVER() AS lowerNum
  FROM Logs
) x
WHERE x.num = x.higherNum AND x.num = x.lowerNum;
```

```sql
-- 585. Investment in 2016
-- COUNT(*) OVER(PARTITION BY) annotates each row with a group-level count,
-- allowing a filter on two separate conditions in one pass.
SELECT ROUND(SUM(tiv_2016)::NUMERIC, 2) AS tiv_2016
FROM (
  SELECT tiv_2016,
    COUNT(*) OVER(PARTITION BY tiv_2015) AS cnt_a,
    COUNT(*) OVER(PARTITION BY lat, lon) AS cnt_b
  FROM Insurance
) c
WHERE c.cnt_a > 1 AND c.cnt_b = 1;
```

---

### LEFT JOIN as an Anti-Join

Using `LEFT JOIN ... WHERE right_table.id IS NULL` to find rows with no match in another table. This came up in several problems — customers who never ordered, employees whose manager left the company, customers who visited but made no transactions.

```sql
-- 183. Customer Who Never Ordered
SELECT c.name AS Customers
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customerId
WHERE o.id IS NULL;
```

---

### Subqueries for Layered Logic

For problems where the answer depends on an intermediate result, subqueries were the clearest path — compute something in an inner query, then filter or aggregate on top of it.

```sql
-- 176. Second Highest Salary
SELECT (
  SELECT salary FROM (
    SELECT salary,
      DENSE_RANK() OVER(ORDER BY salary DESC) AS rnk
    FROM Employee
  ) x
  WHERE x.rnk = 2
  LIMIT 1
) AS SecondHighestSalary;
```

The outer `SELECT` wrapping the subquery is intentional — it returns `NULL` when no second-highest salary exists, rather than returning an empty result set.

---

### UNION / UNION ALL for Multi-Condition Aggregation

`UNION ALL` came up when a value needed to be counted across two different columns in the same table (friend requests — both sender and receiver count as a connection). `UNION` was used in the salary categories problem to assemble fixed output rows for each bucket.

```sql
-- 602. Friend Requests II
SELECT x.id, COUNT(x.id) AS num
FROM (
  (SELECT requester_id AS id FROM RequestAccepted)
  UNION ALL
  (SELECT accepter_id AS id FROM RequestAccepted)
) x
GROUP BY x.id
ORDER BY num DESC
LIMIT 1;
```

---

### Tuple Matching in WHERE

A few PostgreSQL problems used `WHERE (col_a, col_b) IN (subquery)` to match on multiple columns at once — cleaner than joining back to a subquery in those cases.

```sql
-- 1164. Product Price at a Given Date
SELECT product_id, new_price AS price
FROM Products
WHERE (product_id, change_date) IN (
  SELECT product_id, MAX(change_date)
  FROM Products
  WHERE change_date <= '2019-08-16'
  GROUP BY product_id
);
```

---

### Conditional Aggregation

Two approaches came up here. In MySQL, `SUM(condition)` works because boolean expressions evaluate to 0 or 1. In PostgreSQL, the `FILTER (WHERE ...)` clause is a cleaner alternative.

```sql
-- 1193. Monthly Transactions I (PostgreSQL)
SELECT
  TO_CHAR(trans_date, 'YYYY-MM') AS month,
  country,
  COUNT(*) AS trans_count,
  COUNT(*) FILTER(WHERE state = 'approved') AS approved_count,
  SUM(amount) AS trans_total_amount,
  COALESCE(SUM(amount) FILTER(WHERE state = 'approved'), 0) AS approved_total_amount
FROM transactions
GROUP BY 1, 2;
```

---

### Correlated Subqueries for Sliding Windows

The 7-day rolling average problem (1321) uses correlated subqueries to calculate the sum and average for each day's window. Not the only way to solve it, but the approach is readable.

```sql
-- 1321. Restaurant Growth (PostgreSQL)
SELECT visited_on,
  (SELECT SUM(amount) FROM Customer
   WHERE visited_on BETWEEN c.visited_on - INTERVAL '6 days' AND c.visited_on) AS amount,
  ROUND((SELECT SUM(amount) / 7.0 FROM Customer
         WHERE visited_on BETWEEN c.visited_on - INTERVAL '6 days' AND c.visited_on), 2) AS average_amount
FROM Customer c
WHERE visited_on >= (SELECT MIN(visited_on) + INTERVAL '6 days' FROM Customer)
GROUP BY visited_on
ORDER BY visited_on;
-- 7.0 instead of 7 to avoid integer division truncation
```

---

## A Note on Solution Quality

Not every solution here is optimal. A few are explicitly flagged in the file comments — 1661 (Average Time to Process Per Machine) uses three separate correlated subqueries where a single conditional aggregation would have been cleaner. 2356 (Number of Unique Subjects Taught by Each Teacher) uses a double GROUP BY where `COUNT(DISTINCT subject_id)` would have been the direct approach.

Those solutions are left as-is. The point of this repo is to document what I actually wrote, not to go back and tidy everything up. The suboptimal ones are part of the record too.

---

## Tech

- MySQL and PostgreSQL (problem-dependent)
- All solutions accepted on LeetCode
