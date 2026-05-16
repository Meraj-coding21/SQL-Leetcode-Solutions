-- Write your PostgreSQL query statement below
select user_id, name, mail
from Users
where mail ~ '^[A-Za-z][a-zA-Z0-9_.-]*@leetcode\.com$'

-- "-" should be at last cause - in regex is used to define range. 