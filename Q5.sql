-- buyerId, email, first order, recent order, total spend

with base_table as (
	select p.customer_id, p.payment_date,
	row_number() over (partition by p.customer_id order by p.payment_date asc) as early_order,
	row_number() over (partition by p.customer_id order by p.payment_date desc) as late_order
	from payment p
), second_table as (
	select * from base_table bt
	where bt.early_order = 1 or bt.late_order = 1
)

select st.customer_id, max(st.payment_date) as rec_order, min(st.payment_date) as first_order,
(
	select sum(p2.amount) from payment p2 where p2.customer_id = st.customer_id
) as ltv_spend
from second_table st
group by 1 order by 1