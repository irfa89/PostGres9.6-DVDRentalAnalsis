-- Preferred Rating need to figure out how to get ratings.

select * from (
	select t.customer_id, t.rating, count(*),
	row_number() over (partition by t.customer_id order by count(*) desc)
	FROM (
		select r.customer_id, r.inventory_id,i.film_id,f.rating
		from rental r
			join inventory i on r.inventory_id = i.inventory_id
			join film f on f.film_id=i.film_id
		) t group by 1,2 order by 1,3 desc
	) t2 where t2.row_number = 1