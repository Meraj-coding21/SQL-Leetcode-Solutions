select query_name,
       round(avg((rating * 1.0 )/position),2) as quality,
       round(avg((case when rating < 3 then 1
                       when rating >=3 then 0 end)) * 100,2) as poor_query_percentage
                       
from Queries
where query_name is not null 
group by query_nameS