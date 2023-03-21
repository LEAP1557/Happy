SELECT
  dt as dt,
  case
    when channel_id like 'WD%' then 'WD'
    else null
  end as channel_id,
  channel_category,
  sum(uv) as uv,
  sum(click_apply) as shenqing_liangji,
  sum(basic_info) as jibenxinxiye,
  sum(finish_apply) as tijiaoshenpi,
  sum(jihuo) as jihuo_renshu,
  sum(t0_shouhuo) as t_0_shouhuo
FROM
  dmc_oa.dmcoa_cf_baitiao_qty_transform_i_d t
where
  dt between '2021-07-30'
  and '2021-08-11'
  and channel_id like 'WD%'
group by 
dt,
  case
    when channel_id like 'WD%' then 'WD'
    else null
  end,
  channel_category;