--快捷内单下单非白条
SELECT dt,'下单非白条' as type,COUNT(DISTINCT pin) from odm.ODM_CF_XBT_BTFAST_FLOW_REPORT_I_D
where
flowname='FBT_ENTRANCE'
and dt = '{TX_DATE}'
group by dt

--快捷内单可见入口量
SELECT dt,'可见入口' as type,COUNT(DISTINCT pin) from odm.ODM_CF_XBT_BTFAST_FLOW_REPORT_I_D
where
flowname='FBT_ENTRANCE'
and rescode='OK'
and dt = '{TX_DATE}'
group by dt

--快捷内单点击激活并支付
SELECT dt,'点击激活并支付' as type,COUNT(DISTINCT pin) from odm.ODM_CF_XBT_BTFAST_FLOW_REPORT_I_D
where
flowname='FBT_AUTH_DECISION'
and dt = '2021-06-18'
group by dt

--快捷内单申请完成
SELECT dt,'申请完成' as type,COUNT(DISTINCT pin) from odm.ODM_CF_XBT_BTFAST_FLOW_REPORT_I_D
where
flowname='FBT_ACT'
and dt = '{TX_DATE}'
group by dt

--快捷内单激活成功
SELECT dt,'激活成功' as type,COUNT(DISTINCT pin) from odm.ODM_CF_XBT_BTFAST_FLOW_REPORT_I_D
where
flowname='FBT_ACT'
and resCode='SUCCESS'
and dt = '{TX_DATE}'
group by dt
