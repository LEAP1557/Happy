select
  dt,
  chnl_cate,
  chnl_cate_1,
  sum(actv_front_page_user_cnt) as actv_front_page_user_cnt,
  sum(click_apply_user_cnt) as click_apply_user_cnt,
  sum(basic_info_user_cnt) as basic_info_user_cnt,
  sum(auth_user_cnt) as auth_user_cnt,
  sum(actv_user_cnt) as actv_user_cnt,
  sum(t0_fst_user_cnt) as t0_fst_user_cnt,
  sum(t0_genr_fst_user_cnt) as t0_genr_fst_user_cnt
from
  sdm.sdm_f02_cf_xbt_chnl_actv_cnv_indx_i_d a
  left join dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d b on a.chnl_code = b.chnl_code
group by
  1,
  2,
  3
order by
  dt