# Write your MySQL query statement below
select x.id as id, count(x.id) as num
from
((select requester_id as id
from RequestAccepted )

union all

(select accepter_id as id
from RequestAccepted)) x 
group by x.id
order by num desc
limit 1


--find total number of occurrences of each user in both requester_id and accepter_id. 
--then order by count and id to get the user with most friends. 
--union all cause we want to count all occurrences, whereas union would remove duplicates.