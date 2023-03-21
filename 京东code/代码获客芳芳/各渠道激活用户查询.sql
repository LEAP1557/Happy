select
  user_pin
from
  idm.idm_f02_cf_xbt_acct_s_d
where
  actv_chnl_code_lv1 = '6' --渠道值
  and create_time between '2022-01-04 22:23:00'
  and '2022-01-04 23:23:00' --时间段
  and dt = default.sysdate(-1)  --取最新分区
  and acct_type_code in ('0', '1', '5', '6')  --取主账户