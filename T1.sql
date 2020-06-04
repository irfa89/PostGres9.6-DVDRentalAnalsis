-- Time between Events and Mastering Window Functions

-- LAG
 select p.*, lag(p.payment_date) over (),
 lag(p.payment_id) over (),
 lead(p.payment_id) over ()
 from payment p

-- Difference   -- results as interval
select t.*,t.payment_date - t.prior_order from (
	 select 
		p.*, lag(p.payment_date) over () as prior_order
	 	from payment p
	 ) t


