-- Write your PostgreSQL query statement below
select round((c1 * 1.0 / c2) * 100,2) as immediate_percentage
from
    (select
    count(*) filter(where order_date = customer_pref_delivery_date and rnk=1)as c1,
    count(distinct customer_id) as c2
    from
        (select *,
        row_number() over (partition by customer_id order by order_date asc) as rnk
        from delivery) )