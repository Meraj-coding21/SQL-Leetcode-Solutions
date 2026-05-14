-- Write your PostgreSQL query statement below
select round((count(distinct player_id)::numeric / (select count(distinct player_id) from activity)::numeric), 2) as fraction
from activity
where (player_id, event_date) in (select player_id, (min(event_date) 
      + interval '1  day')::date 
      from activity 
      group by player_id)

-- in where we can pass values using commas. 
-- if stuck somewhere to find a single value try to use subquery