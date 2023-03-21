select
  substr(fst_consm_time, 1, 10) dt,
  genr_fst_type_code,
  count(1) c
from
  idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where
  dt = '{TX_DATE}' and hlth_flag=1 --健康
--   and substr(fst_consm_time, 1, 10) between '2021-09-01'
--   and '2021-09-16'
group by
  substr(fst_consm_time, 1, 10),
  genr_fst_type_code