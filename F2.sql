-- row number 
-- getting a list of orders by staff member, in reverse order
-- get customers most recent orders

select * from
(
select p.*,
	row_number() over(partition by p.customer_ID order by p.payment_date desc) as row
	from payment p
	order by 2
)t where t.row = 1

-- with clause alternate
with first_orders as (
	select * from
	(
	select p.*,
		row_number() over(partition by p.customer_ID order by p.payment_date desc) as row
		from payment p
		order by 2
	)t where t.row = 1
)

select * from first_orders
