alter table
    keepcoding.ivr_detail
add
    column info_by_dni_lg int64;

update
    keepcoding.ivr_detail ivd
set
    ivd.info_by_dni_lg = case
        when exists (
            select
                1
            from
                keepcoding.ivr_steps s
            where
                s.ivr_id = ivd.calls_ivr_id
                and s.step_name = 'CUSTOMERINFOBYDNI.TX'
                and s.step_result = 'OK'
        ) then 1
        else 0
    end
where
    ivd.calls_ivr_id is not null;