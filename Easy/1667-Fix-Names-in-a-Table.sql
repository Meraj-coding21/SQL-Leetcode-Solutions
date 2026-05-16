-- Write your PostgreSQL query statement below
select user_id,
concat(upper(left(name, 1)), lower(substring(name,2, length(name)))) as name
from Users
order by user_id

-- left needs value how far we want to go from most left position. 
-- if we dont give length(name) in substring(), it will still be alright cause if not lenth mentioned it runs untill the end of the string.
