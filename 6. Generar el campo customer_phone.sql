update
  keepcoding.ivr_detail d
set
  d.customer_phone = s.customer_phone
from
  (
    select
      ivr_id,
      array_agg(
        customer_phone
        order by
          step_sequence asc
        limit
          1
      ) [safe_offset(0)] as customer_phone
    from
      keepcoding.ivr_steps
    where
      customer_phone <> 'UNKNOWN'
    group by
      ivr_id
  ) s
where
  d.calls_ivr_id = s.ivr_id
  and d.customer_phone = 'UNKNOWN';