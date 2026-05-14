-- Write your PostgreSQL query statement below
select e1.employee_id, e1.name, count(e2.employee_id) as reports_count, round(avg(e2.age)) as average_age
from employees e1
join employees e2
on e2.reports_to = e1.employee_id
group by e1.employee_id, e1.name
order by e1.employee_id

-- if want to convert a value to nearest integar use round()
