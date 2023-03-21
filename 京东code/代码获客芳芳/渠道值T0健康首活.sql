select
  substr(t1.fst_consm_time, 1, 10) as time,
  count(distinct t1.user_pin) as c_user_pin
from
  idm.idm_f02_cf_xbt_user_fst_ordr_a_d t1
inner join (select * from idm.idm_f02_cf_xbt_loan_flag_i_d where new_hlth_flag = '1' and (
        biz_code not in(8, 9, 10, 11, 12, 13, 16, 23, 25, 26, 32, 64, 65)
        or biz_code is null
      )) t2 on t1.fst_loan_id = t2.loan_id
inner join (select * from idm.idm_f02_cf_xbt_acct_s_d where dt = '{TX_DATE}' and acct_type_code in ('0', '1', '5', '6') and 
substr(actv_time,1,10) = '2021-10-26') t3 on t1.user_pin = t3.user_pin
where substr(t1.fst_consm_time, 1, 10) in ('2021-10-26','2021-10-27','2021-10-28','2021-10-29')
group by
  substr(t1.fst_consm_time, 1, 10)