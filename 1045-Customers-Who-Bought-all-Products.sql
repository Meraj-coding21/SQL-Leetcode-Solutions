# Write your MySQL query statement below
select customer_id
from Customer
group by customer_id
having count(distinct product_key) = (select count(*) from Product)

-- we use having when we want to filter the groups. 
-- in this case we want to filter the customers who bought all the products. 
-- so we use having count(distinct product_key) = (select count(*) from Product) to filter the customers who bought all the products.