update
  keepcoding.ivr_detail d
set
  d.document_type = s.document_type,
  d.document_identification = s.document_identification
from
  (
    select
      ivr_id,
      array_agg(
        document_type
        order by
          step_sequence asc
        limit
          1
      ) [safe_offset(0)] as document_type,
      array_agg(
        document_identification
        order by
          step_sequence asc
        limit
          1
      ) [safe_offset(0)] as document_identification
    from
      keepcoding.ivr_steps
    where
      document_type <> 'UNKNOWN'
      and document_identification <> 'UNKNOWN'
    group by
      ivr_id
  ) s
where
  d.calls_ivr_id = s.ivr_id
  and (
    d.document_type = 'UNKNOWN'
    or d.document_identification = 'UNKNOWN'
  );