select to_date(fst_consm_time) dt,--日期
count(distinct user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-01-01' and '2021-12-12'
and (hlth_flag=1 or stud_flag = 1) --健康标记（排除达成价值时刻高龄或线下尝鲜激活用户）
and actv_chnl_code = 'WD110225410016'
group by 1;