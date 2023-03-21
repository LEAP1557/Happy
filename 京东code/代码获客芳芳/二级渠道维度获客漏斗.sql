select
  create_time,
  channel_id,
  secondCode,
  sum(uv) as uv,
  sum(actv_cnt) as actv_cnt -- 激 活 量,
  sum(T0_fst_loan) as T0_fst_loan -- T0 首 活 量
from(
    select
      dt as create_time,
      parse_url(ct_url, 'QUERY', 'channelName') as channel_id,
      coalesce(parse_url(ct_url, 'QUERY', 'secondCode'), '未知') as secondCode,
      count(distinct user_pin) as uv,
      0 as actv_cnt,
      0 as T0_fst_loan
    from
      idm.idm_f03_web_online_i_d
    where
      dt between date_add('{TX_DATE}', -6)
      and '{TX_DATE}' -- 近 8 天,      需 要 时 间 段 ， 更 改 前 面 数 字 即 可
      and ct_url like '%bt.jd.com/v3/mobile/rGuide_initGuideMobile%' - -103002082986
      and parse_url(ct_url, 'QUERY', 'channelName') = '103002082986'
    group by
      1,
      2,
      3
    union all
    select
      t.dt,
      t.channelname,
      coalesce(t.secondcode, '未知') as secondcode,
      0 as uv,
      count(distinct t.jdpin) as actv_cnt,
      count(
        distinct case
          when datediff(to_date(new_deal_time), t.dt) = 0 then t1.pin
        end
      ) as T0_fst_loan
    from
      odm.odm_cf_xbt_bt_act_marketing_i_d t -- 激 活
      left join (
        select
          createtime,
          pin,
          new_deal_time,
          cx_pb_time
        from
          dmc_bc.dmcbc_bc_cf_xbt_account_s_d
        where
          dt = '{TX_DATE}'
          and to_date(new_deal_time) between date_add('{TX_DATE}', -6)
          and '{TX_DATE}'
          and source_id = '103002082986'
      ) t1 on t.jdpin = t1.pin
    where
      t.dt between date_add('{TX_DATE}', -6)
      and '{TX_DATE}'
      and t.channelname = '103002082986'
    group by
      t.dt,
      t.channelname,
      coalesce(t.secondcode, '未知')
  ) t
group by
  create_time,
  channel_id,
  secondCode;