select
  substr(t1.loan_time, 1, 10) as l_time,
  t1.source_type1,
  t1.source_type2,
  count(distinct t1.user_pin) as user_cnt
from(
    select
      tt.loan_time,
      tt.source_type1,
      tt.source_type2,
      tt.user_pin 
    from
     (
        select
          loan_time,
          user_pin,
          source_type1,
          source_type2,
          row_number() over(
            partition by user_pin
            order by
              loan_time
          ) as rownum
          from
      dmc_bc.dmcbc_bc_cf_xbt_ordr_base_s_d
    where
      dt = '2021-08-09'--取最新的时间、今天是8月9日就填写2021-08-08
      and substr(loan_time, 1, 10) between '2021-01-01'
      and '2021-03-30' --取要查询的时间
      and substr(actvtime, 1, 10) between date_sub(substr(loan_time, 1, 10), 3)
      and substr(loan_time, 1, 10)
      and (
        biz_id not in(8, 9, 10, 11, 12, 13, 16, 23, 25, 26, 32, 64, 65)
        or biz_id is null
      )
      ) tt
      where
      tt.rownum = 1
      and (
        substr(tt.loan_time, 1, 10) between '2021-01-01'
        and '2021-06-30' --取 要 查 询 的 时 间
      )

  ) t1
  left join (
    select
      user_pin
    from
      idm.idm_f02_cf_xbt_loan_flag_i_d
    where
      dt >= '2021-01-01'--不变
      and (
        hlth_flag = 0 -- 不 健 康 用 户
        or loan_user_age > 55
      )
    group by
      user_pin
    union
    select
      user_pin
    from
      idm.idm_f02_cf_xbt_acct_s_d
    where
      dt = '2021-08-09'--取最新的时间、今天是8月9日就填写2021-08-08
      and acct_type_code in ('0', '1', '5', '6')
      and fresh_bt_acct_flag = 1
      and (
        fst_lvl_inds_cate_name = '服务产业'
        or onl_or_ofl_code = 'offline'
        or fst_lvl_inds_cate_name = '用户中心'
      )
      and actv_chnl_code_lv1 not in (
        '103003191624',
        '102000524072',
        '2741',
        'WD110214978004',
        '102001493402',
        '103003191625',
        '102001384331',
        'WD110214978029',
        'WD110214978001',
        '103002874818'
      ) -- 排 除 到 家
  ) t2 on t1.user_pin = t2.user_pin
where
  t2.user_pin is null
group by
  substr(t1.loan_time, 1, 10),
  t1.source_type1,
  t1.source_type2;