select
  t1.loan_ti,
  --时间
  t5.chnl_online,
  count(distinct t1.user_pin) jkusers
from
  (
    select
      substr(t.loan_time, 1, 10) as loan_ti,
      t.user_pin as user_pin,
      t.loan_id as loan_id
    from
      (
        select
          ad.loan_id as loan_id,
          ad.user_pin as user_pin,
          ad.loan_time as loan_time,
          row_number() over(
            partition by ad.user_pin
            order by
              ad.loan_time
          ) as rownum
        from dmc_bc.dmcbc_bc_cf_xbt_ordr_base_s_d ad --订单表
        where ad.dt = DATE_ADD('{TX_DATE}', 0) --更改日期
          and (
            biz_id not in (8, 9, 10, 11, 12, 13, 16, 23, 25, 26, 32, 64, 65)
            or biz_id is null
          )
      ) t
    where
      t.rownum = 1
      and (
        substr(t.loan_time, 1, 10) between '2022-01-01' and '2022-01-06'
      ) --更改日期
  ) t1
  left join idm.idm_f02_cf_xbt_loan_flag_i_d t2 on t1.loan_id = t2.loan_id
  left join (
    select
      t3.user_pin as user_pin,
      t3.acct_type_code as acct_type_code,
      t4.chnl_online as chnl_online
    from idm.idm_f02_cf_xbt_acct_s_d t3,dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d t4
    where t3.actv_chnl_code_lv1 = t4.chnl_code
    --   or t3.actv_chnl_code_lv1 is null
      and t3.dt = default.sysdate(-1) --取最新分区
  ) t5 on t1.user_pin = t5.user_pin
where
  t2.new_hlth_flag = 1
  and t5.acct_type_code in ('0', '1', '5', '6') --取主账户
group by
  t1.loan_ti,
  t5.chnl_online
order by
  t1.loan_ti asc;