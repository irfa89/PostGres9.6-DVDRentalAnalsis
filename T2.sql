
select t.*,
	t.payment_date - t.prior_order as some_interval, -- raw interval
	extract (epoch from t.payment_date - t.prior_order)/3600 as hours_since -- interval to hours
	from(
			select p.*,
						lag(p.payment_date) over(partition by p.customer_id) as prior_order
			from payment p
	) t
	
-- Alternate sysntax and some moving calculations

select p.*, avg(p.amount) over w
from payment p
window w as (order by p.payment_id rows between 7 preceding and 0 following)  -- compute moving average

-- moving average
select p.*, avg(p.amount) over w as avg_over_prior7,
avg(p.amount) over w2 as back3_fwd_3_avg
from payment p
window w as (order by p.payment_id rows between 7 preceding and 0 following),
		w2 as (order by p.payment_id rows between 3 preceding and 3 following)




