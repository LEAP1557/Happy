select
  to_date(act_fst_time) as uv_dt,
  '金融APP' as typ,
  count(distinct a.user_pin) as pin_count_all,
  --金融活跃
  count(b.user_pin) as pin_count_bt,
  --白条用户
  count(distinct a.user_pin) - count(b.user_pin) as pin_count_notbt --非白
from
  idm.idm_f03_app_jrapp_user_actv_dtl_i_d a
  left join (
    select
      user_pin,
      dt
    from
      idm.idm_f02_cf_xbt_acct_s_d
    where
      dt between '2020-01-01'
      and '2021-11-01'
    group by
      dt,
      user_pin
  ) b --金融APP登录
  on a.user_pin = b.user_pin
  and to_date(a.act_fst_time) = to_date(b.dt)
where
  to_date(act_fst_time) between '2020-01-01'
  and '2021-11-01'
group by
  to_date(act_fst_time);