select id
from (select id,temperature,recordDate,
    lag(temperature) over(order by recordDate) as prev_temp,
    lag(recordDate) over(order by recordDate) as prev_date
    from Weather) x
where (x.temperature > x.prev_temp) and (datediff(x.recordDate,x.prev_date) = 1)