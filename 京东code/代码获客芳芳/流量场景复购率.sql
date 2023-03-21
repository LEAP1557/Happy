select
  a.loan_time as loan_time,
  a.fst_type as fst_type,
  a.sec_type as sec_type,
  a.cx_pb as cx_pb,
  count(distinct a.pinsh) as shouhuo,
  count(
    distinct case
      when delt_time = 0
      and row_num > 1 then a.pinsh
    end
  ) as t0_reloan,
  count(
    distinct case
      when delt_time between 1
      and 3 then a.pinsh
    end
  ) as t3_reloan,
  count(
    distinct case
      when delt_time between 1
      and 7 then a.pinsh
    end
  ) as t7_reloan,
  count(
    distinct case
      when delt_time between 1
      and 30 then a.pinsh
    end
  ) as t30_reloan,
  count(
    distinct case
      when delt_time between 1
      and 90 then a.pinsh
    end
  ) as t90_reloan,
  count(
    distinct case
      when delt_time between 31
      and 60 then a.pinsh
    end
  ) as nextmon
from
  dmc_oa.dmcoa_cf_baitiao_reloan_s_d a
  left join dmc_add.dmcadd_add_cf_xbt_jdbt_chnl_and_src_a_d b on a.source_id = b.chnl_code
--   left join dmc_add.dmcadd_add_cf_xbt_actv_cls_divid_insid_part_a_d b on a.source_id = b.channel_code
where
  a.loan_time between '2021-11-01'
  and '2021-12-30'
--   and b.sec_type = '线下'
--   and b.chnl_online = '京东其他渠道'
  and b.chnl_code in (    
    -- "WD110214978004",
    -- "102001493402",
    -- "WD110214978029",
    -- "102000524072",
    -- "102001384331",
    -- "102001527759",
    -- "102001724997",
    "WD110214978001"
    -- "32",
    -- "102001385846",
    -- "102000486935",
    -- "2741",
    -- "102000215850" --到家
  ) 
  and a.dt = '{TX_DATE}' -- substr(loan_time,1,10)<=cast(date_add('day', -1, current_date) as varchar)
  -- and dt=cast(date_add('day', -1, current_date) as varchar)
group by
  1,
  2,
  3,
  4