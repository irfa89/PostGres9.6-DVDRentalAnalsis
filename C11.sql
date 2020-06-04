-- first , first 7, 14 days, etc...
-- idea of interval

--select d , d + '1 week' as aweekfromnow 
--from generate_series('2017-01-01', current_date, interval '1 day') d

with bt as (
				select * from
				(select p.customer_id,p.payment_date, row_number() over(partition by p.customer_id order by p.payment_date)
				from payment p
			) t where t.row_number = 1
	      )
select bt.*, 
(
	select sum(p2.amount) from payment p2 where p2.customer_id = bt.customer_id
	and p2.payment_date between bt.payment_date and bt.payment_date + interval '7 days'
) as first7_sales ,
(
	select sum(p2.amount) from payment p2 where p2.customer_id = bt.customer_id
	and p2.payment_date between bt.payment_date and bt.payment_date + interval '14 days'
) as first14_sales ,
(
	select sum(p2.amount) from payment p2 where p2.customer_id = bt.customer_id
	--and p2.payment_date between bt.payment_date and bt.payment_date + interval '14 days'
) as ltv
from bt bt