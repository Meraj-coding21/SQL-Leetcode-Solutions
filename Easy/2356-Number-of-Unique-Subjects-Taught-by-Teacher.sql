-- Write your PostgreSQL query statement below
select x.teacher_id, count(x.teacher_id) as cnt
from (select teacher_id
from Teacher
group by teacher_id, subject_id) x
group by x.teacher_id

--very poor solution. try to use count(distinct subject_id) instead of group by teacher_id, subject_id and then count the teacher_id.
