select
  t1.loan_ti,
  count(distinct t1.user_pin) jkusers
from
  (
    select
      substr(t.loan_time, 1, 7) as loan_ti,
      t.user_pin,
      t.ordr_id
    from
      (
        select
          *,
          row_number() over(
            partition by user_pin
            order by
              loan_time
          ) as rownum
        from
          dmc_bc.dmcbc_bc_cf_xbt_ordr_base_s_d ad
        where
          dt = DATE_ADD('{TX_DATE}', 0) -- 更 改 日 期
          and (
            biz_id not in(8, 9, 10, 11, 12, 13, 16, 23, 25, 26, 32, 64, 65)
            or biz_id is null
          )
      ) t
    where
      t.rownum = 1
      and (
        (
          substr(t.loan_time, 1, 10) between '2021-10-01'
          and DATE_ADD('{TX_DATE}', 0)
        )
        or (
          substr(t.loan_time, 1, 10) between '2020-10-01'
          and DATE_ADD('{TX_DATE}', -365)
        )
      ) -- 更 改 日 期
  ) t1
  left join (
    select
      a1.ordr_id
    from
      idm.idm_f02_cf_xbt_loan_flag_i_d as a1
    where
      a1.dt >= '2020-08-01'
      and (a1.new_hlth_flag = 1)
    group by
      a1.ordr_id
  ) t2 on t1.ordr_id = t2.ordr_id
where
  t2.ordr_id is not null
group by
  t1.loan_ti
order by
  t1.loan_ti asc;