alter table
    keepcoding.ivr_detail
add
    column masiva_lg int64;

update
    keepcoding.ivr_detail ivd
set
    ivd.masiva_lg = case
        when exists (
            select
                1
            from
                keepcoding.ivr_modules m
            where
                m.ivr_id = ivd.calls_ivr_id
                and m.module_name = 'AVERIA_MASIVA'
        ) then 1
        else 0
    end
where
    ivd.calls_ivr_id is not null;