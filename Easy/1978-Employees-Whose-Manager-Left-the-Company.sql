select e1.employee_id 
from Employees e1
left join Employees e2 on e1.manager_id= e2.employee_id
where e1.salary < 30000
and e1.manager_id is not NULL
and e2.employee_id is NULL 
order by e1.employee_id