select
  loan_time,
  sum(shouhuo) as shouhuo,
  sum(nextmon) as nextmon
from
  dmc_oa.dmcoa_cf_mth_reorder_s_d a,
  dmc_add.dmcadd_add_cf_xbt_actv_cls_divid_insid_part_a_d b
where
  a.source_id = b.channel_code and substr(a.source_id,1,2) != 'WD'
  and b.fst_type = '外部'
  and dt = default.sysdate(-1)  --取最新分区
  and a.loan_time between '2020-06-01'
  and '2021-10-11'
group by
  loan_time
  

select
  loan_time,
  sum(shouhuo) as shouhuo,
  sum(nextmon) as nextmon
from
  dmc_oa.dmcoa_cf_mth_reorder_s_d a
--   dmc_add.dmcadd_add_cf_xbt_actv_cls_divid_insid_part_a_d b
where
--   a.source_id = b.channel_code
--   and b.fst_type = '外部'
  dt = default.sysdate(-1)  --取最新分区
  and a.loan_time between '2020-06-01'
  and '2021-10-11'
group by
  loan_time

