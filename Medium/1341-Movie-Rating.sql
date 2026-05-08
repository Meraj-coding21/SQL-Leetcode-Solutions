-- Concept: we can use avg, count at last with order by. union all unions everything, whereas union will remove dulicates.
-- in postgre, we can use extract() to get month and year from date. In mysql, its month() and year().
(select Users.name as results
from Users
join MovieRating using(user_id)
group by user_id, Users.name
order by count(rating) desc, Users.name
limit 1)

union all

(select title as results
from Movies
join MovieRating using(movie_id)
where extract(month from created_at) = 2 and 
      extract(year from created_at) = 2020
group by movie_id, title
order by avg(rating) desc, title
limit 1)