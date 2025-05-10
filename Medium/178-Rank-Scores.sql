-- Problem: 178. Rank Scores
-- Difficulty: Easy
-- Link: https://leetcode.com/problems/rank-scores/
--
-- Explanation:
-- We use DENSE_RANK() to assign a ranking to each score in descending order.
-- DENSE_RANK handles duplicate scores by assigning the same rank to equal values.
-- We use backticks (`rank`) to safely alias the column since 'rank' is a reserved keyword in MySQL.

select score,
dense_rank() over(order by score desc) as `rank`
from Scores;