--分流量场景
select
  stats_dt,
  brs_scene_name,
  genr_new_tx_user_cnt_2,
  val_new_tx_user_cnt_2,
  year_new_tx_user_cnt_2
from
  sdm.sdm_f02_cf_xbt_genr_new_index_day_sum_i_d
where
  stats_dt between '2022-01-07' and '2022-01-13'
  and brs_scene_name != 'ALL'

--分业务部门
select
  stats_dt,
  opr_dept_name,
  genr_new_tx_user_cnt_2,
  val_new_tx_user_cnt_2,
  year_new_tx_user_cnt_2
from
  sdm.sdm_f02_cf_xbt_genr_new_index_day_sum_i_d
where
  stats_dt between '2021-11-23' and '2021-12-21'
  and opr_dept_name != 'ALL'
