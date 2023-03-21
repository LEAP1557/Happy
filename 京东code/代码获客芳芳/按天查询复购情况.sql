select 
         loan_time as loan_time,
         source_id as source_id,
         fst_type as fst_type,
         sec_type as sec_type,
         cx_pb as cx_pb,
         count(distinct pinsh) as shouhuo,
         count(distinct case when delt_time=0 and row_num>1 then pinsh end) as t0_reloan,
         count(distinct case when delt_time between 1 and 3 then pinsh end) as t3_reloan,
         count(distinct case when delt_time between 1 and 7 then pinsh end) as t7_reloan,
         count(distinct case when delt_time between 1 and 30 then pinsh end) as t30_reloan,
         count(distinct case when delt_time between 1 and 90 then pinsh end) as t90_reloan,
         count(distinct case when delt_time between 31 and 60 then pinsh end) as nextmon
 from dmc_oa.dmcoa_cf_baitiao_reloan_s_d--复购率
 where loan_time between '2021-12-25' and '2022-01-06' and source_id = '6' and dt = '2022-01-06'
 -- substr(loan_time,1,10)<=cast(date_add('day', -1, current_date) as varchar)
 -- and dt=cast(date_add('day', -1, current_date) as varchar)
 group by 1,2,3,4,5