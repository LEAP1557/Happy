select
  substr(loan_time,1,7) as loan_time,
  sum(chengben)/sum(shouhuorenshu) as chengben
from
  dmc_oa.dmcoa_cf_baitiao_fst_cost_i_d
where channel_category = '用户中心' and shouhuorenshu != 0
  and substr(loan_time,1,7) = '2020-10'
group by
  substr(loan_time,1,7)
  
  
select * from dmc_oa.dmcoa_cf_baitiao_fst_cost_i_d limit 100


--分流量场景周成本
select
  t1.loan_time,
  t2.chnl_online,
  sum(t1.chengben) / sum(t1.shouhuorenshu) as cost
from
  dmc_oa.dmcoa_cf_baitiao_fst_cost_i_d t1
left join dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d t2 on t1.channel_id = t2.chnl_code
where
  loan_time between '2022-01-07'
  and '2022-01-13'
group by 
  t1.loan_time,
  t2.chnl_online

--汇总周成本  
select
  sum(t1.chengben) / sum(t1.shouhuorenshu) as cost
from
  dmc_oa.dmcoa_cf_baitiao_fst_cost_i_d t1
where
  loan_time between '2022-01-07'
  and '2022-01-13'

--汇总白条产品部（卡）成本  
select
  t1.loan_time,
  sum(t1.chengben) / sum(t1.shouhuorenshu) as cost
from
  dmc_oa.dmcoa_cf_baitiao_fst_cost_i_d t1
-- left join dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d t2 on t1.channel_id = t2.chnl_code
where t1.channel_id = '21ffkhd'
  loan_time between '2022-01-07'
  and '2022-01-13'
group by 
  t1.loan_time