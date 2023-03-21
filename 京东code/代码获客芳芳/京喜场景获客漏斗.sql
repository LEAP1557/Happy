select
  coalesce(b.createtime, a.createtime) as createtime,
  coalesce(b.channel_id, a.channel_id) as channel_id,
  coalesce(b.channel_category, a.channel_category) as channel_category,
  coalesce(b.channel_name, a.channel_name) as channel_name,
  coalesce(b.uv, a.uv) as uv,
  coalesce(b.click_apply, a.click_apply) as click_apply,
  coalesce(b.basic_info, a.basic_info) as basic_info,
  coalesce(b.finish_apply, a.finish_apply) as finish_apply,
  coalesce(b.jihuo, a.jihuo) as jihuo,
  coalesce(b.cx_jihuo, a.cx_jihuo) as cx_jihuo,
  coalesce(b.pb_jihuo, a.pb_jihuo) as pb_jihuo,
  coalesce(b.t0_shouhuo, a.t0_shouhuo) as t0_shouhuo,
  coalesce(b.t7_shouhuo, a.t7_shouhuo) as t7_shouhuo,
  coalesce(b.t30_shouhuo, a.t30_shouhuo) as t30_shouhuo,
  coalesce(b.t0_sj, a.t0_sj) as t0_sj,
  coalesce(b.t7_sj, a.t7_sj) as t7_sj,
  coalesce(b.t30_sj, a.t30_sj) as t30_sj
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
      jihuo,
      0 as cx_jihuo,
      0 as pb_jihuo,
      t0_shouhuo,
      t7_shouhuo,
      t30_shouhuo,
      0 as t0_sj,
      0 as t7_sj,
      0 as t30_sj
    from
      dmc_oa.dmcoa_cf_impw_baitiao_i_d
    where
      channel_category <> '失败页'
      and dt between date_add('{TX_DATE}', -50)
      and '{TX_DATE}'
      and source_id in (
        '102000517192',
        '102000525097',
        '102001089331',
        '102001089333',
        '102001089336',
        '103000615434',
        '103002083006'
      )
  ) a full
  join (
    select
      createtime,
      channel_id as channel_id,
      channel_category,
      channel_name,
      uv,
      click_apply,
      basic_info,
      finish_apply,
      jihuo,
      cx_jihuo,
      pb_jihuo,
      t0_shouhuo,
      t7_shouhuo,
      t30_shouhuo,
      t0_sj,
      t7_sj,
      t30_sj
    from
      dmc_oa.dmcoa_cf_baitiao_tranfm_new_i_d
    where
      dt between date_add('{TX_DATE}', -50)
      and '{TX_DATE}'
      and channel_id in (
        '102000517192',
        '102000525097',
        '102001089331',
        '102001089333',
        '102001089336',
        '103000615434',
        '103002083006'
      )
  ) b on a.createtime = b.createtime
  and a.channel_id = b.channel_id
  and a.channel_category = b.channel_category
  and a.channel_name = b.channel_name;