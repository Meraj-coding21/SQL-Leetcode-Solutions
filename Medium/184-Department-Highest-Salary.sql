select Department,Employee,Salary
from (select d.name as Department,e.name as Employee, e.salary as Salary,
      dense_rank() over(partition by d.name order by e.salary desc) as rnk
      from Employee e
      join Department d on e.departmentId = d.id) x
where x.rnk = 1;