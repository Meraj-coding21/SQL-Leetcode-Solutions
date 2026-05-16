-- Write your PostgreSQL query statement below
select person_name
from (select person_name,
      sum(weight) over(order by turn) as cum_weight
      from Queue)
where cum_weight <=1000
order by cum_weight desc
limit 1

-- when we put order by turn inside over() it calculates running total
