select activity_date as day, count(distinct user_id) as active_users
from Activity
where activity_date between  '2019-07-27'::date - interval '29 days' and '2019-07-27'
group by activity_date

-- :: to typecast string to date. 
-- first select the range, then group by activity_date and lastly count the distinct users for each day.