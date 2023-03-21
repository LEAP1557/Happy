select to_date(fst_consm_time) dt,--日期
count(user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-11-05' and '2021-11-11'
and hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
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
count(user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-11-12' and '2021-11-18'
and hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
group by 1,2) a left join 
(select to_date(fst_consm_time) dt,--日期
bi_opr_dept_name,
count(case when genr_fst_type_code in (1,2) then user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then user_pin end) valueuser_new2--价值用户-2类-新达成-首贷当天结清但后续复购
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where dt=default.sysdate(-1)
and to_date(fst_consm_time) between '2021-11-12' and '2021-11-18'
and hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
and bi_opr_dept_name is not null
group by 1,2) b --双记补充
on a.opr_dept_name=b.bi_opr_dept_name and a.dt=b.dt
;

--流量场景拆分
select to_date(fst_consm_time) dt,--日期
brs_scene_name,
count(user_pin) users,--价值用户-总
count(case when genr_fst_type_code in (1,2) then user_pin end) valueuser_new,--价值用户-新达成
count(case when genr_fst_type_code in (1) then user_pin end) valueuser_new1,--价值用户-1类-新达成-首贷当天未结清
count(case when genr_fst_type_code in (2) then user_pin end) valueuser_new2,--价值用户-2类-新达成-首贷当天结清但后续复购
count(case when genr_fst_type_code in (3) then user_pin end) valueuser_awake --价值用户-3类-年新-剔除新达成2类重合
from idm.idm_f02_cf_xbt_user_genr_fst_ordr_s_d
where dt=default.sysdate(-2)
and to_date(fst_consm_time) between '2021-11-12' and '2021-11-18'
and hlth_flag=1 --健康标记（排除达成价值时刻学生、高龄或线下尝鲜激活用户）
group by 1,2
;