-- Write your PostgreSQL query statement below
select sell_date, count(distinct product) as num_sold,
string_agg(distinct product, ',' order by product) as products
from Activities
group by sell_date
order by sell_date

--string_agg() adds column values with comma separation and order by organizes it in lexiographical order.
