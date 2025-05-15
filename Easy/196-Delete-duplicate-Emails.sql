delete from Person
where id in(select id 
            from(select id,
            row_number() over(partition by email order by id) as rn
            from Person) x
            where x.rn > 1)