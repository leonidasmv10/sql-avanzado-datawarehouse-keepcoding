update
  keepcoding.ivr_detail d
set
  d.billing_account_id = s.billing_account_id
from
  (
    select
      ivr_id,
      array_agg(
        billing_account_id
        order by
          step_sequence asc
        limit
          1
      ) [safe_offset(0)] as billing_account_id
    from
      keepcoding.ivr_steps
    where
      billing_account_id <> 'UNKNOWN'
    group by
      ivr_id
  ) s
where
  d.calls_ivr_id = s.ivr_id
  and d.billing_account_id = 'UNKNOWN';