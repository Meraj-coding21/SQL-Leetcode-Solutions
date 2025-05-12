select distinct num as ConsecutiveNums from
    (select num,
    lead(num) over() as higherNum,
    lag(num) over() as lowerNum
    from Logs) x
where x.num=x.higherNum and x.num=x.lowerNum