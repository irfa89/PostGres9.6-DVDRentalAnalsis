with random_numbers as (
	select random() * 100 as val
	from generate_series(1,100)
)

select rn.*, 
	case 
		when rn.val < 50 then 'lt_50'
		when rn.val >= 50 then 'gte_50'
		else 'others'
		END as rand_outcome
from random_numbers rn

-- Get order number

with order_nbrs as (
	select p.*, row_number() over(partition by p.customer_id order by p.payment_date) as row
	from payment p
)

select ons.*,
	case 
		when ons.row = 1 then 'first_order'
		when ons.row > 1 then 'repeat_order'
		else 'order_outcome' end as order_outcome
from order_nbrs ons