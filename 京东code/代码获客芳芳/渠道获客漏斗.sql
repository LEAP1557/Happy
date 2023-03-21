select
  createtime as createtime,
  channel_id as channel_id,
  channel_category as channel_category,
  channel_name as channel_name,
  sum(uv) as uv,
  sum(click_apply) as click_apply,
  sum(basic_info) as basic_info,
  sum(finish_apply) as finish_apply,
  sum(jihuo) as jihuo,
  sum(cx_jihuo) as cx_jihuo,
  sum(pb_jihuo) as pb_jihuo,
  sum(t0_shouhuo) as t0_shouhuo,
  sum(t7_shouhuo) as t7_shouhuo,
  sum(t30_shouhuo) as t30_shouhuo,
  sum(t0_sj) as t0_sj,
  sum(t7_sj) as t7_sj,
  sum(t30_sj) as t30_sj,
  sum(t3_shouhuo) as t3_shouhuo,
  sum(t3_sj) as t3_sj,
  createtime as dt
from
  (
    select
      createtime,
      source_id as channel_id,
      case
        when channel_category = '用户中心' then '用户业务'
        when channel_category = '政企合作' then '线下生态'
        when channel_category is not null then channel_category
        when substr(source_id, 1, 4) in ('KFPT', 'HLBT') then '服务产业'
        when substr(source_id, 1, 2) = 'WD' then '服务产业'
        else '京东生态'
      end as channel_category,
      channel_name,
      uv,
      apply as click_apply,
      info as basic_info,
      shenpi as finish_apply,
      0 as jihuo,
      0 as cx_jihuo,
      0 as pb_jihuo,
      0 as t0_shouhuo,
      0 as t7_shouhuo,
      0 as t30_shouhuo,
      0 as t0_sj,
      0 as t7_sj,
      0 as t30_sj,
      0 as t3_shouhuo,
      0 as t3_sj
    from
      dmc_oa.dmcoa_cf_impw_baitiao_i_d
    where
      channel_category <> '失败页'
      and dt = date_add('2021-09-23', -1)
    union
    select
      createtime,
      channel_id as channel_id,
      channel_category,
      channel_name,
      0 as uv,
      0 as click_apply,
      0 as basic_info,
      finish_apply,
      jihuo,
      cx_jihuo,
      pb_jihuo,
      t0_shouhuo,
      t7_shouhuo,
      t30_shouhuo,
      t0_sj,
      t7_sj,
      t30_sj,
      t3_shouhuo,
      t3_sj
    from
      dmc_oa.dmcoa_cf_baitiao_tranfm_new_i_d
    where
      dt = date_add('2021-09-23', -1)
  ) t
group by
  1,
  2,
  3,
  4,
  20;