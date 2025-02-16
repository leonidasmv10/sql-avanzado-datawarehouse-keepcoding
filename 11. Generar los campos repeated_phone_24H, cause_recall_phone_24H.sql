alter table
    keepcoding.ivr_detail
add
    column if not exists repeated_phone_24h int64,
add
    column if not exists cause_recall_phone_24h int64;

-- actualizar el campo repeated_phone_24h
update
    keepcoding.ivr_detail ivd
set
    ivd.repeated_phone_24h = case
        when exists (
            select
                1
            from
                keepcoding.ivr_calls c_prev
            where
                c_prev.phone_number = ivd.calls_phone_number
                and c_prev.start_date between timestamp_sub(ivd.calls_start_date, interval 24 hour)
                and ivd.calls_start_date
                and c_prev.ivr_id != ivd.calls_ivr_id
        ) then 1
        else 0
    end
where
    ivd.calls_phone_number is not null;

-- actualizar el campo cause_recall_phone_24h
update
    keepcoding.ivr_detail ivd
set
    ivd.cause_recall_phone_24h = case
        when exists (
            select
                1
            from
                keepcoding.ivr_calls c_next
            where
                c_next.phone_number = ivd.calls_phone_number
                and c_next.start_date between ivd.calls_start_date
                and timestamp_add(ivd.calls_start_date, interval 24 hour)
                and c_next.ivr_id != ivd.calls_ivr_id
        ) then 1
        else 0
    end
where
    ivd.calls_phone_number is not null;