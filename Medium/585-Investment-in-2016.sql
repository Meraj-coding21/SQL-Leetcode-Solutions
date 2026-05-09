-- Write your PostgreSQL query statement below
select round(sum(tiv_2016)::numeric ,2) as tiv_2016
from
    (select tiv_2016,
    count(*) over (partition by tiv_2015) as cnt_a,
    count(*) over (partition by lat,lon) as cnt_b
    from Insurance) c
where c.cnt_a > 1 and c.cnt_b = 1

-- whenever need to count something based on a condition, we can use window functions to count the occurrences of that condition for each row.
-- if we want to count same things in two columns, we can use count(*) over (partition by column_names) to count the occurrences of that column value for each row.
-- need to typecast to numeric to get the decimal result for tiv_2016. converts integer to numeric.