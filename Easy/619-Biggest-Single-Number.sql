# Write your MySQL query statement below
select(select num 
from MyNumbers
group by num
having count(num) = 1
order by num desc
limit 1) as num

-- this requires to output null if there is no single number.
-- So we use select statement to output null if there is no single number.