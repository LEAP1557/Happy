select
  createtime,
  sum(uv) as uv,
  sum(click_apply) as click_apply,
  sum(finish_apply) as finish_apply,
  sum(jihuo) as jihuo,
  sum(t0_shouhuo) as t0_shouhuo,
  sum(t30_shouhuo) as t30_shouhuo
from
  dmc_oa.dmcoa_cf_baitiao_qty_transform_i_d a,
  dmc_add.dmcadd_add_cf_xbt_actv_cls_divid_insid_part_a_d b
where
  a.channel_id = b.channel_code
  and b.sec_type = '线下'
--   and substr(a.channel_id,1,2) != 'WD'
  and a.createtime between '2021-01-01'
  and '2021-10-31'
group by
  createtime
