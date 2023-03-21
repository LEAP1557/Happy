--数据新uv
select
  dt,
  channel_id,
  count(distinct pin) as pin_cnt
from
  (
    select
      dt,
      reverse(split(reverse(note_key_id), ',') [0]) as channel_id,
      substr(
        uuid,
        length(note_key_id) + 1,
        length(uuid) - length(note_key_id)
      ) as pin
    from
      idm.idm_f03_brs_jr_sjl_biz_log_i_d
    where
      dt between '2021-09-01'
      and '2021-09-21'
      and (
        note_key_id like '%SAS_GUIDE_INIT,H5,NEW_GUIDE_PAGE%'
        or note_key_id like '%SAS_GUIDE_INIT,H5,STD_ACT_FRESH_PAGE%'
        or note_key_id like 'SAS_GUIDE_INIT,H5,ASSETCOFFER_GO,%'
      )
      and biz_id = 'JR,BAITIAO,PS'
    union
    select
      dt,
      parse_url(ct_url, 'QUERY', 'channelName') as channel_id,
      user_pin as pin
    from
      idm.idm_f03_web_online_i_d
    where
      dt between '2020-09-01'
      and '2020-09-21'
      and (
        ct_url like '%mbt.jd.com/process/std_active/actGuideB.html%'
        or ct_url like '%mbt.jd.com/external/taste-fresh/actGuide.html%'
      )
  ) t
where t.channel_id = '103002083006'
group by
  1,
  2;