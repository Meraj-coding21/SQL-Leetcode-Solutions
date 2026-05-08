-- Write your PostgreSQL query statement below
select to_char(trans_date,'YYYY-MM') as month,
country,
count(*) as trans_count,
count(*) filter(where state = 'approved') as approved_count,
sum(amount) as trans_total_amount,
coalesce(sum(amount) filter(where state = 'approved'),0) as approved_total_amount
from transactions
group by 1,2