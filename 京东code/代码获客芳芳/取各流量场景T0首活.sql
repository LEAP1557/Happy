select
  a.dt,
  b.chnl_online,
  sum(a.t0_fst_loan_cnt) as sum_t0_loan_cnt
from
  dmc_oa.dmcoa_cf_bt_chnl_new_user_i_d a,
  dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d b
where
  a.channel = b.chnl_code and a.dt between '2020-01-01' and '2020-05-30'
group by
  a.dt,
  b.chnl_online
order by
  dt
