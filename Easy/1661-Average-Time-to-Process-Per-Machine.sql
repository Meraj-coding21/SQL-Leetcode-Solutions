select machine_id,
round((((select sum(timestamp) from Activity where activity_type ="end" and machine_id = a.machine_id)-    
        (select sum(timestamp) from Activity where activity_type = "start" and machine_id=a.machine_id))/
        (select count(distinct process_id) from Activity where machine_id=a.machine_id)),3) as processing_time
from Activity a
group by machine_id;

--one of the worst solutions-- :')