use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_ord_dtl;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_ord_dtl as
select a.*,hlth_flag,loan_user_age,repay_finish_time from
(select * 
,row_number() over(partition by user_pin order by loan_time) rn
,lag(loan_time,1,'1900-01-01 00:00:00') over(partition by user_pin order by loan_time) time_last
,dense_rank() over(partition by user_pin order by substr(loan_time,1,10)) rn_dt
from sdm.sdm_f02_cf_xbt_ordr_dtl_s_d
where dt=default.sysdate(-1) 
and (biz_id not in ('8','9','10','11','12','13','16','23','25','26','32','64','65') or biz_id is null)) a left join idm.idm_f02_cf_xbt_loan_flag_i_d c on a.loan_id=c.loan_id and a.ordr_id=c.ordr_id
left join idm.idm_f02_cf_xbt_loan_dtl_s_d b on a.user_pin=b.user_pin and b.dt=default.sysdate(-1) and a.loan_id=b.loan_id and a.ordr_id=b.ordr_id
;

use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_userpin;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_userpin as
select a.*,b.loan_time fst_time,b.hlth_flag fst_hlth_flag,b.loan_user_age fst_loan_user_age
from
(select user_pin pin,create_time,fresh_bt_acct_flag,onl_or_ofl_code,fst_lvl_inds_cate_name,actv_chnl_code_lv1,actv_chnl_name_lvl1
from idm.idm_f02_cf_xbt_acct_s_d 
where dt= default.sysdate(-1) 
and acct_type_code in ('0','1','5','6') ) a 
left join dmc_dev.btgyx_bt_ord_dtl b on a.pin=b.user_pin and b.rn=1
;

use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_userpin1;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_userpin1 as
select t1.*,t2.amt_fstdt,t2.amt_fstdt_jq_cmplt,t3.secdt_time,t3.secdt_hlth_flag,t3.secdt_loan_user_age
from dmc_dev.btgyx_bt_userpin t1 
left join
(
select pin,sum(loan_prin) amt_fstdt,sum(case when to_date(fst_time)=to_date(repay_finish_time) then loan_prin when to_date(fst_time)=to_date(refund_time) and loan_prin=refund_prin then refund_prin else 0 end) amt_fstdt_jq_cmplt
from dmc_dev.btgyx_bt_userpin a inner join
dmc_dev.btgyx_bt_ord_dtl b on a.pin=b.user_pin and b.rn_dt=1
group by 1
) t2 on t1.pin=t2.pin
left join
(select user_pin,min(loan_time) secdt_time,min(hlth_flag) secdt_hlth_flag,min(loan_user_age) secdt_loan_user_age from dmc_dev.btgyx_bt_ord_dtl where rn_dt=2 group by 1) t3 on t1.pin=t3.user_pin
;

use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_userpin_1yrnew;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_userpin_1yrnew as
select a.*,b.*
from dmc_dev.btgyx_bt_ord_dtl a 
inner join 
dmc_dev.btgyx_bt_userpin b on a.user_pin=b.pin and a.time_last>'1900-01-01 00:00:00' and datediff(a.loan_time,a.time_last)>=365
;

use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_userpin2;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_userpin2 as
select a.*
,case 
when amt_fstdt=amt_fstdt_jq_cmplt then secdt_time
else fst_time end value_tm
,case 
when amt_fstdt=amt_fstdt_jq_cmplt then secdt_hlth_flag
else fst_hlth_flag end value_hlth_flag
,case 
when amt_fstdt=amt_fstdt_jq_cmplt then secdt_loan_user_age
else fst_loan_user_age end value_loan_user_age
,case when actv_chnl_name_lvl1='联营白条' then '服务产业方案部' when actv_chnl_code_lv1 is null then '全渠道运营部' when chnl_cate is null then '白条产品部' else chnl_cate end chnl_cate,chnl_cate_1
,case when actv_chnl_name_lvl1='联营白条' then '外部场景' when actv_chnl_code_lv1 is null then '京东主站' when chnl_online is null then '外部场景' else chnl_online end chnl_online
,case when actv_chnl_name_lvl1='联营白条' then '外部场景' when actv_chnl_code_lv1 is null then '京东主站' when chnl_online_dtl is null then coalesce
(chnl_online,'外部场景') else chnl_online_dtl end chnl_online_dtl
,case 
when amt_fstdt=amt_fstdt_jq_cmplt then 2
else 1 end value_typ
from dmc_dev.btgyx_bt_userpin1 a
left join dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d--dmc_dev.ywzzb_bt_chnl_cate0826 
c on a.actv_chnl_code_lv1=trim(c.chnl_code) and chnl_code!=''--行业划分维表
;


use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_bt_userpin_1yrnew_1;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_bt_userpin_1yrnew_1 as
select a.*
,
case
when biz_id in ('1','4','6','39','67','46') or biz_id is null 
then '全渠道运营部'
when e.zl_code is not null --直连
or d.sec_mht is not null --五星
then '白条产品部'
when b.sub_no is not null --服务产业商户号
or a.sub_mht_no in ('110225410008','110225410016','111434658002','111317672003','110225410010','111097131013') --物流
or a.sub_mht_no in ('110214978004', '110214978029', '110214978001','110333663001','110333663002') --到家、7fresh （3+2）
or a.sub_mht_no in ('110214978012','110214978013','110245102005') --到家商户号（遗漏）
then '服务产业方案部'
when biz_id in ('40','54','57','61','41','49','51','52','53','55','58','63','70') then '服务产业方案部' ---联营白条
when biz_id in ('3', '5', '7', '27', '50') then '用户业务部' --金融app
when c.loan_id is not null then '融合产品部' --分分卡
else '服务产业方案部' --其余外单
end chnl_cate_2,
case
when biz_id in ('1','4','6','39','67','46') or biz_id is null then '京东主站'
when a.sub_mht_no in ('110214978004', '110214978029', '110214978001','110333663001','110333663002') --到家、7fresh （3+2）
or a.sub_mht_no in ('110214978012','110214978013','110245102005') --到家商户号（遗漏）
or a.sub_mht_no in ('110225410008','110225410016','111434658002','111317672003','110225410010','111097131013') --物流
or d.sec_mht is not null --五星
then '京东其他渠道'
when biz_id in ('3', '5', '7', '27', '50') then '金融APP' --金融app
when c.loan_id is not null then '微信场景' --分分卡
else '外部场景' --其余外单
end chnl_online_1
from dmc_dev.btgyx_bt_userpin_1yrnew a 
left join (select distinct sec_mht_code as sub_no from dmc_add.dmcadd_add_cf_xbt_jdbt_serv_mercht_a_d) b on a.sub_mht_no = b.sub_no
left join (select distinct loan_id
from idm.idm_f02_cf_xbt_loan_dtl_s_d
where dt = default.sysdate(-1) and biz_code='22' and sub_biz_code in ('2','3')) c on a.loan_id=c.loan_id and a.biz_id='22' 
left join (select distinct trim(sec_mht) sec_mht from dmc_add.dmcadd_add_cf_xbt_offline_mht_a_d where pr_nm='五星电器') d on a.sub_mht_no = d.sec_mht
left join (select trim(regexp_replace(chnl_code,'WD','')) zl_code from dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d--dmc_dev.ywzzb_bt_chnl_cate0826 
where chnl_name like '%线下白条直连%') e on a.sub_mht_no = e.zl_code
;


use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_value_userpin;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_value_userpin as
select coalesce(a.pin,b.user_pin) pin,coalesce(value_tm,loan_time) value_tm,coalesce(value_hlth_flag,b.hlth_flag) value_hlth_flag,coalesce(value_loan_user_age,b.loan_user_age) value_loan_user_age
,chnl_cate,chnl_cate_1,chnl_cate_2,coalesce(chnl_cate,chnl_cate_2) chnl_cate_0,coalesce(value_typ,3) value_typ,case when b.user_pin is not null then 3 end hx_flag,coalesce(a.fresh_bt_acct_flag,b.fresh_bt_acct_flag) fresh_bt_acct_flag,coalesce(a.onl_or_ofl_code,b.onl_or_ofl_code,'online') onl_or_ofl_code
,coalesce(chnl_online,chnl_online_1) chnl_online,coalesce(chnl_online_dtl,chnl_online_1) chnl_online_dtl
from (select * from dmc_dev.btgyx_bt_userpin2 where value_tm is not null) a 
full outer join
dmc_dev.btgyx_bt_userpin_1yrnew_1 b 
on a.pin=b.user_pin and substr(a.value_tm,1,7)=substr(b.loan_time,1,7)
;

-- use dmc_dev;
-- DROP TABLE IF EXISTS dmc_dev.btgyx_value_userpin;
-- CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_value_userpin as
-- select coalesce(a.pin,b.user_pin) pin,coalesce(value_tm,loan_time) value_tm,coalesce(value_hlth_flag,b.hlth_flag) value_hlth_flag,coalesce(value_loan_user_age,b.loan_user_age) value_loan_user_age
-- ,chnl_cate,chnl_cate_1,chnl_cate_2,coalesce(chnl_cate,chnl_cate_2) chnl_cate_0,coalesce(value_typ,3) value_typ,case when b.user_pin is not null then 3 end hx_flag,coalesce(a.fresh_bt_acct_flag,b.fresh_bt_acct_flag) fresh_bt_acct_flag,coalesce(a.onl_or_ofl_code,b.onl_or_ofl_code,'online') onl_or_ofl_code
-- ,coalesce(chnl_online,chnl_online_1) chnl_online,coalesce(chnl_online_dtl,chnl_online_1) chnl_online_dtl
-- ,coalesce(a.actv_chnl_code_lv1,b.actv_chnl_code_lv1) actv_chnl_code_lv1,b.biz_id hx_biz_id,b.sub_mht_no hx_sub_mht_no
-- from (select * from dmc_dev.btgyx_bt_userpin2 where value_tm is not null) a 
-- full outer join
-- dmc_dev.btgyx_bt_userpin_1yrnew_1 b 
-- on a.pin=b.user_pin and substr(a.value_tm,1,7)=substr(b.loan_time,1,7)
-- ;

--天数较多时建议MR

set mapreduce.map.memory.mb=8192;
set mapreduce.reduce.memory.mb=8192;
set mapreduce.reduce.java.opts=-Xmx6556M;
set mapreduce.map.java.opts=-Xmx6556M;
set hive.auto.convert.join=false;
use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_value_userpin_cnt;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_value_userpin_cnt as
select t1.grouping__id,t1.dt,t1.chnl_cate_0,t1.users_jz,t1.valueuser1,t1.valueuser2,t1.valueuser3,t2.valueuser1 valueuser1_1,t2.valueuser2 valueuser2_1
from
(select grouping__id, substr(value_tm,1,10) dt,chnl_cate_0,count(pin) users_jz,count(case when value_typ=1 then pin end) valueuser1,count(case when value_typ=2 then pin end) valueuser2,count(case when hx_flag=3 then pin end) valueuser3
from dmc_dev.btgyx_value_userpin
where substr(value_tm,1,10) between '2020-01-01' and '2021-09-09' and value_hlth_flag=1 and coalesce(value_loan_user_age,0)<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by substr(value_tm,1,10),chnl_cate_0
grouping sets(substr(value_tm,1,10),(substr(value_tm,1,10),chnl_cate_0))
) t1
left join
(select  substr(value_tm,1,10) dt,chnl_cate_1,count(pin) users_jz,count(case when value_typ=1 then pin end) valueuser1,count(case when value_typ=2 then pin end) valueuser2,count(case when hx_flag=3 then pin end) valueuser3
from dmc_dev.btgyx_value_userpin
where substr(value_tm,1,10) between '2020-01-01' and '2021-09-09' and chnl_cate_1 is not null and value_hlth_flag=1 and coalesce(value_loan_user_age,0)<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by substr(value_tm,1,10),chnl_cate_1
) t2 
on t1.dt=t2.dt and t1.grouping__id=0 and t1.chnl_cate_0=t2.chnl_cate_1
;

--以上为建立底表


--价值总计，无双记
select dt
,users_jz --价值用户-总
,valueuser1+valueuser2 valueuser_new --价值用户-新达成
,valueuser1 --价值用户-1类-新达成-首贷当天未结清
,valueuser2 --价值用户-2类-新达成-首贷当天结清但后续复购
,valueuser3 --价值用户-3类-年新-含与新达成2类重合
,users_jz-valueuser1-valueuser2 valueuser3_1 --价值用户-3类-年新-剔除新达成2类重合
from dmc_dev.btgyx_value_userpin_cnt where grouping__id=1 and dt = '2021-09-09';

--拆解行业层-含双记
select dt
,chnl_cate_0 --行业划分
,users_jz+coalesce(valueuser1_1,0)+coalesce(valueuser2_1,0) --价值用户-总-含双记
,valueuser1+valueuser2+coalesce(valueuser1_1,0)+coalesce(valueuser2_1,0) valueuser_new --价值用户-新达成-含双记
,valueuser1+coalesce(valueuser1_1,0) valueuser_new_1 --价值用户-1类-新达成-首贷当天未结清-含双记
,valueuser2+coalesce(valueuser2_1,0) valueuser_new_2 --价值用户-2类-新达成-首贷当天结清但后续复购-含双记
,users_jz-valueuser1-valueuser2 valueuser3_1 --价值用户-年新-剔除新达成2类重合
from dmc_dev.btgyx_value_userpin_cnt where grouping__id=0 and chnl_cate_0 is not null and dt = '2021-09-09';


use dmc_dev;
DROP TABLE IF EXISTS dmc_dev.btgyx_value_userpin_cnt_online;
CREATE TABLE IF NOT EXISTS dmc_dev.btgyx_value_userpin_cnt_online as
select grouping__id, substr(value_tm,1,10) dt,chnl_online,count(pin) users_jz,count(case when value_typ=1 then pin end) valueuser1,count(case when value_typ=2 then pin end) valueuser2,count(case when hx_flag=3 then pin end) valueuser3
from dmc_dev.btgyx_value_userpin
where substr(value_tm,1,10) between '2020-01-01' and '2021-09-09' and value_hlth_flag=1 and coalesce(value_loan_user_age,0)<=55 and (fresh_bt_acct_flag=0 or coalesce(onl_or_ofl_code,'online')='online')
group by substr(value_tm,1,10),chnl_online
grouping sets(substr(value_tm,1,10),(substr(value_tm,1,10),chnl_online))
;

--拆解流量场景-无双记
select 
 dt
,chnl_online --流量来源划分
,users_jz --价值用户-总
,valueuser1+valueuser2 valueuser_new --价值用户-新达成
,valueuser1 --价值用户-1类-新达成-首贷当天未结清
,valueuser2--价值用户-2类-新达成-首贷当天结清但后续复购
,users_jz-valueuser1-valueuser2 valueuser3_1 --价值用户-年新-剔除新达成2类重合
from dmc_dev.btgyx_value_userpin_cnt_online where grouping__id=0 and chnl_online is not null and dt = '2021-09-09';