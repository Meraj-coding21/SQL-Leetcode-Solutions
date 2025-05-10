-- Problem: 175. Combine Two Tables
-- Difficulty: Easy
-- Link: https://leetcode.com/problems/combine-two-tables/
--
-- Explanation:
-- We are asked to return all people from the Person table,
-- along with their address if it exists. So we use LEFT JOIN
-- to ensure people without an address are still included.

select firstName, lastName, city, state
from Person p
left join Address a on p.personId = a.personId