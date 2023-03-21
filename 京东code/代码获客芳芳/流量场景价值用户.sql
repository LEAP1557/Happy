select
  dt,
  chnl_cate,
  day_genr_new_user_cnt,
  day_fst_ordr_user_cnt,
  day_year_awake_user_cnt
--   day_fst_ordr1_user_cnt,
--   day_fst_ordr2_user_cnt
from
  dmc_ll.dmcll_cf_bt_genr_user_index_i_d
where
  chnl_type = '流量场景' 
  and chnl_cate != '全部'
  and dt between '2021-11-24' and '2021-11-25' --取最新分区
