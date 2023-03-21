select
  substr(t.consm_time, 1, 10) as loan_time,
  count(distinct t1.user_pin) as user_cnt
from(
    select
      *
    from(
        select
          *,
          row_number() over(
            partition by a.user_pin
            order by
              consm_time asc
          ) as rn
        from
          idm.idm_f02_cf_xbt_loan_dtl_s_d a
        where
          a.dt = '{TX_DATE}'
          and (
            a.biz_code not in (
              '8',
              '9',
              '10',
              '11',
              '12',
              '13',
              '16',
              '23',
              '25',
              '26'
            )
            or a.biz_code is null
          )
      ) t
    where
      rn = 1
      and substr(consm_time, 1, 10) between '2021-12-01' and '2021-12-31'
  ) t
  left join (
    select
      user_pin
    from
      idm.idm_f02_cf_xbt_acct_s_d
    where
      dt = '{TX_DATE}'
    --   and onl_or_ofl_code = 'offline'
    --   or actv_chnl_code_lv1 = 'WD110225410016'
  ) t1 on t.user_pin = t1.user_pin
group by
  substr(t.consm_time, 1, 10);




-----简化版
select
  substr(t.consm_time, 1, 10) as loan_time,
  count(distinct t1.user_pin) as user_cnt
from(
    select
      *
    from(
        select
          *,
          row_number() over(
            partition by a.user_pin
            order by
              consm_time asc
          ) as rn
        from
          idm.idm_f02_cf_xbt_loan_dtl_s_d a
        where
          a.dt = '{TX_DATE}'
          and (
            a.biz_code not in (
              '8',
              '9',
              '10',
              '11',
              '12',
              '13',
              '16',
              '23',
              '25',
              '26'
            )
            or a.biz_code is null
          )
      ) t
    where
      rn = 1
      and substr(consm_time, 1, 10) between '2021-12-01' and '2021-12-31'
  ) t
  group by 1
