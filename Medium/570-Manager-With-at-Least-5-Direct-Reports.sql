select e.name
from Employee e
join Employee m on e.id = m.managerId
group by m.managerId
having count(m.managerId) >= 5;