-- Finding all data about a customer first order.
-- Should have 1 one row for each customer.
-- the min is determined by payment date.

select p.* from payment p
join (
	select p2.customer_id, min(p2.payment_date) as fo_date
	from payment p2
	group by 1
) t on t.fo_date = p.payment_date
order by 2