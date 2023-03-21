--价值用户总数
select to_date(fst_consm_time) dt,--日期
count(a.user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then a.user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then a.user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then a.user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then a.user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d a 
left join idm.idm_f02_cf_xbt_loan_flag_i_d b on a.fst_loan_id=b.loan_id 
left join (select user_pin pin,create_time,fresh_bt_acct_flag,onl_or_ofl_code,fst_lvl_inds_cate_name,actv_chnl_code_lv1,actv_chnl_name_lvl1,crdt_lmt
from idm.idm_f02_cf_xbt_acct_s_d 
where dt= default.sysdate(-1) 
and acct_type_code in ('0','1','5','6')) c on a.user_pin=c.pin
where a.dt= default.sysdate(-1) 
and to_date(fst_consm_time) = '2021-12-06'
--and a.hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
and loan_user_age<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by 1; 

--行业拆分（含双记）
select a.dt,
opr_dept_name,
a.users+coalesce(b.valueuser_new,0) users,--价值用户-总（含双记）
a.valueuser_new+coalesce(b.valueuser_new,0) valueuser_new,--价值用户-新达成（含双记）
a.valueuser_new1+coalesce(b.valueuser_new1,0) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清（含双记）
a.valueuser_new2+coalesce(b.valueuser_new2,0) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购（含双记）
a.valueuser_awake--价值用户-3类-年新-剔除新达成2类重合
from
(select to_date(fst_consm_time) dt,--日期
opr_dept_name,
count(a.user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then a.user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then a.user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then a.user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then a.user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d a 
left join idm.idm_f02_cf_xbt_loan_flag_i_d b on a.fst_loan_id=b.loan_id 
left join (select user_pin pin,create_time,fresh_bt_acct_flag,onl_or_ofl_code,fst_lvl_inds_cate_name,actv_chnl_code_lv1,actv_chnl_name_lvl1,crdt_lmt
from idm.idm_f02_cf_xbt_acct_s_d 
where dt= default.sysdate(-1) 
and acct_type_code in ('0','1','5','6')) c on a.user_pin=c.pin
where a.dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-06-16' and '2021-06-30'
--and hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
and loan_user_age<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by 1,2) a left join 
(select to_date(fst_consm_time) dt,--日期
bi_opr_dept_name,
count(case when genr_fst_type_code in (1,2) then a.user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then a.user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then a.user_pin end) valueuser_new2--价值用户-2类-新达成-首贷当天结清但后续复购
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d a 
left join idm.idm_f02_cf_xbt_loan_flag_i_d b on a.fst_loan_id=b.loan_id 
left join (select user_pin pin,create_time,fresh_bt_acct_flag,onl_or_ofl_code,fst_lvl_inds_cate_name,actv_chnl_code_lv1,actv_chnl_name_lvl1,crdt_lmt
from idm.idm_f02_cf_xbt_acct_s_d 
where dt= default.sysdate(-1) 
and acct_type_code in ('0','1','5','6')) c on a.user_pin=c.pin
where a.dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-06-16' and '2021-06-30'
--and a.hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
and loan_user_age<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
and bi_opr_dept_name is not null
group by 1,2) b --双记补充
on a.opr_dept_name=b.bi_opr_dept_name and a.dt=b.dt
;

--流量场景拆分
select to_date(fst_consm_time) dt,--日期
brs_scene_name,
count(a.user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then a.user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then a.user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then a.user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then a.user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d a 
left join idm.idm_f02_cf_xbt_loan_flag_i_d b on a.fst_loan_id=b.loan_id 
left join (select user_pin pin,create_time,fresh_bt_acct_flag,onl_or_ofl_code,fst_lvl_inds_cate_name,actv_chnl_code_lv1,actv_chnl_name_lvl1,crdt_lmt
from idm.idm_f02_cf_xbt_acct_s_d 
where dt= default.sysdate(-1) 
and acct_type_code in ('0','1','5','6')) c on a.user_pin=c.pin
where a.dt= default.sysdate(-1) 
and to_date(fst_consm_time) between '2021-12-01' and '2021-12-05'
--and a.hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
and loan_user_age<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by 1,2
;