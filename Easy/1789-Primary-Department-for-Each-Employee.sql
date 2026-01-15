select x.employee_id, x.department_id
from
(select *,
row_number() over (partition by employee_id order by primary_flag desc) as row_num
from Employee) x
where row_num = 1
