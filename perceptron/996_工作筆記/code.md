
# 10K回流


应用系统：10K 

```sql
select
        jdpin
    from
        dmx_bc.dmxbc_aggr_usr_crowd_back_i_d
    where
        crowd_id='8db2d0ee-1182-4e38-8b1c-b65080594eef' and dt='2022-08-15'
    group by 1

```

**回流：（标签-群体） +（sql-群体）  人群pin也可以回流**



# 支付

#### 区分信用卡、储蓄卡

```sql


select substr(pay_succ_time,1,7) as mth,
case when card_type='1' then '储蓄卡' else '信用卡' end as card_type,
sum(pay_succ_amt) pay_succ_amt
from idm.idm_f02_pay_in_tx_dtl_i_d
where
	pay_tool_lv1 in ('applepay','jdzf','wx','other')
	and (pay_tool_lv2!='sys' or pay_tool_lv2 is null) --排除扫一扫订单 -- pay_tool_lv2<>
	and pay_chnl in ('app','h5','pc') --主站
	and bus_lv3='sc'
	and pay_tool_lv1<>'cod'
	and pay_tool_lv2='kj'
	and dt between '2021-01-01' and '2022-12-31'
	and substr(pay_succ_time,1,10) between '2021-01-01' and '2022-12-31'
	and card_type in ('1','2','4') --0:未知 1:借记卡 2:贷记卡 3:预付费卡 4:准贷记卡
group by 1,2;
```



# 交易

#### scene

```sql
  select a.dt  
          ,a.loan_id  
          ,a.ordr_id  
          ,a.user_pin  
          ,a.consm_time  
          ,a.loan_amt   
          ,a.plan_num   
          ,a.fst_lvl_scene_type_code  
          ,a.fst_lvl_scene_type_name  
          ,a.sec_lvl_scene_type_code  
          ,a.sec_lvl_scene_type_name  
          ,a.trd_lvl_scene_type_code  
          ,a.trd_lvl_scene_type_name  
          ,a.self_biz_pct  
          ,b.recvbl_stag_fee  
          ,b.stag_fee  
          ,b.cnv_time  
          ,COALESCE(b.actl_fee_rate,c.exec_rate) as actl_fee_rate --执行费率  
          ,COALESCE(b.refund_prin,c.refund_prin) refund_prin --订单粒度退款  
    from   
      (  
      select * from idm.idm_f02_cf_xbt_loan_scene_type_i_d   
      where (dt >= trunc(add_months('{TX_DATE}',-3),'MM') and dt <= '{TX_DATE}') --每天跑近4个月的每日数据   
            or (dt >= trunc(add_months('{大头TX_DATE}',-15),'MM') and dt <= add_months('{TX_DATE}',-12))  
      )a  
    left join   
       (    
       select * from sdm.sdm_f02_cf_xbt_ordr_dtl_s_d  
       where dt = '{TX_DATE}'   
        and (biz_id not in ('8','9','10','11','12','13','16','23','25','26','32','64','65') or biz_id is null)  
       ) b on a.loan_id = b.loan_id and a.consm_time=b.loan_time
```




# 策略

#### 生命周期划分逻辑脚本
```sql

use dmc_dev;
    drop table if exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t01;
    create table if not exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t01 as
    select 
    user_pin,datediff('{TX_DATE}',to_date(create_time)) as bt_mobs
    from (  
    select user_pin,create_time,dt,row_number() over(partition by user_pin order by create_time) as rn
    from idm.idm_f02_cf_xbt_acct_s_d --小白条账户表
    where dt ='{TX_DATE}' --用的日期是7.13
    and acct_type_code in ('0','1','5','6') --账户类型代码
    and main_acct_ind = 0 --主账户标志 0是，1否
    )t
    where rn=1
    ;



    use dmc_dev;
    drop table if exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t02;
    create table if not exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t02 as
    select user_pin,count(distinct ordr_id) as zf_sc_cnt_90d,count(distinct if(pay_tool_lv2 = 'bt',ordr_id,null)) as zf_sc_bt_cnt_90d 
    from 
    idm.idm_f02_pay_in_tx_dtl_i_d
    where dt between date_sub('{TX_DATE}',90) and '{TX_DATE}'  
    and pay_tool_lv1 in('applepay','jdzf','wx','other') --只计算applypay、京东支付、微信和其他类订单
    and pay_tool_lv2!='sys' --排除扫一扫订单
    and bus_lv3='sc' 
    group by 1    
    ;




    use dmc_dev;
    drop table if exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t03;
    create table if not exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t03 as
    select user_pin,to_date(loan_time) as bt_last_or_date,rn from 
    (select *, row_number() over(partition by user_pin order by loan_time desc) as rn 
    from sdm.sdm_f02_cf_xbt_ordr_dtl_s_d 
    where  dt = '{TX_DATE}' 
    and (biz_id not in ('8','9','10','11','12','13','16','23','25','26','32','64','65') or biz_id is null))a 
    --where rn = 1 
    ;



    use dmc_dev;
    drop table if exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t04;
    create table if not exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t04 as
    select *
    from 
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t03
    where rn =1 
    ;




    use dmc_dev;
    drop table if exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t05;
    create table if not exists dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t05 as
    select *
    from 
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t03
    where rn =  2 
    ;




    set mapreduce.reduce.memory.mb=8192; 
    set mapreduce.reduce.java.opts=-Xmx6550m;
    select *
    from 
    (
    select t1.user_pin as pin,case when t1.user_pin is not null and t3.user_pin is null then '未首单'
                         when  datediff('{TX_DATE}',to_date(t3.bt_last_or_date)) > 365 then '年新'
                         when  to_date(t3.bt_last_or_date) between  date_sub('{TX_DATE}',365) and date_sub('{TX_DATE}',150) then '流失期'
                         when  to_date(t3.bt_last_or_date) between  date_sub('{TX_DATE}',151) and date_sub('{TX_DATE}',91) then '衰退期'
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs > 90 and t4.user_pin is null then '引入期' 
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs > 90 and zf_sc_bt_cnt_90d/zf_sc_cnt_90d >= 0.4 and  datediff('{TX_DATE}',to_date(t3.bt_last_or_date)) <= 20 then '成熟期'
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs > 90 and zf_sc_bt_cnt_90d/zf_sc_cnt_90d >= 0.4 and  datediff('{TX_DATE}',to_date(t3.bt_last_or_date)) > 20  then '预衰退期'
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs > 90 and t3.user_pin is not null  and zf_sc_bt_cnt_90d/zf_sc_cnt_90d < 0.4 and  datediff('{TX_DATE}',to_date(t3.bt_last_or_date)) <= 20 then '成长期'
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs > 90 and t3.user_pin is not null  and zf_sc_bt_cnt_90d/zf_sc_cnt_90d < 0.4 and  datediff('{TX_DATE}',to_date(t3.bt_last_or_date)) > 20 then '预衰退期'                     
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs <= 90 and t4.user_pin is null then '引入期'
                         when zf_sc_bt_cnt_90d > 0 and bt_mobs <= 90 then '成长期'
                         else null
                         end as group_name
    from 
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t01 t1 --账户激活情况
    left join
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t02 t2 --90天内交易情况
    on t1.user_pin = t2.user_pin
    left join 
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t04 t3 --末单及末单时间
    on t1.user_pin = t3.user_pin
    left join 
    dmc_dev.tmp_dmcqm_qmemp_bt_new_lifecycle_i_d_t05 t4 --是否完成次单
    on t1.user_pin = t4.user_pin
    left join 
    (
        select *
        from 
        dmc_qm.dmcqm_qmemp_superbt_bt_user_i_d
        where dt = '{TX_DATE}' and tag = 'chaobai'
    ) t5 --超白已激活用户
    on t1.user_pin = t5.pin
    where t5.pin is null 
    )a 
    where group_name is not null 
    ;
```




