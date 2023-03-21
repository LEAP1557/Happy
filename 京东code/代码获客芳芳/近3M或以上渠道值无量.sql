SELECT
  a.channel_category,
  a.channel_id
FROM
  (
    SELECT
      dt as dt,
      channel_id,
      channel_category,
      uv as uv,
      click_apply as shenqing_liangji,
      basic_info as jibenxinxiye,
      finish_apply as tijiaoshenpi,
      jihuo as jihuo_renshu,
      t0_shouhuo as t_0_shouhuo
    FROM
      dmc_oa.dmcoa_cf_baitiao_qty_transform_i_d t
    where
      dt between '2020-08-09'
      and '2021-05-10'
      and (
        uv > 0
        or jihuo > 0
      )
  ) as t
  left join (
    SELECT
      channel_category as channel_category,
      channel_id as channel_id,
      sum(uv) as uv,
      sum(click_apply) as shenqing_liangji,
      sum(jihuo) as jihuo_renshu
    FROM
      dmc_oa.dmcoa_cf_baitiao_qty_transform_i_d
    where
      dt between '2021-05-09'
      and '2021-08-09'
    group by
      channel_category,
      channel_id
    having
      sum(uv) = 0
      and sum(click_apply) = 0
      and sum(jihuo) = 0
  ) as a on t.channel_id = a.channel_id
where
  a.channel_id is not null
group by
  1,
  2
limit
  1000;