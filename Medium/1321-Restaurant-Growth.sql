-- Write your PostgreSQL query statement below

select visited_on,
                (select sum(amount)
                from Customer
                where visited_on between c.visited_on - interval '6 days' 
                and c.visited_on ) as amount,
                round((select sum(amount)/7.0
                from Customer
                where visited_on between c.visited_on - interval '6 days' 
                and c.visited_on ),2) as average_amount
from Customer c
where visited_on >= (select min(visited_on) + interval '6 days'
                    from Customer)
group by visited_on
order by visited_on

--used correlated subqueries to calculate the sum and average amount for each day.
--with 7.0 it does integer division, so we need to use 7.0 to get a decimal result for average_amount.