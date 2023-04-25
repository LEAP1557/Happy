‘

### 窗口函数 sum() over()
http://lxw1234.com/archives/2015/04/176.htm
- 分组全部加总 SUM(pv) OVER(PARTITION BY cookieid) AS pv3
-  分组顺序累加 1.  SUM(pv) OVER(PARTITION BY cookieid ORDER BY createtime) AS pv1, -- 默认为从起点到当前行


### Get_json
SELECT get_json_object('{"a":"b"}', '$.a');
https://docs.databricks.com/sql/language-manual/functions/get_json_object.html


1.get单层值

hive> select  get_json_object(data, '$.owner') from test;
结果：amy
1
2
2.get多层值.

hive> select  get_json_object(data, '$.store.bicycle.price') from test;
结果：19.95
1
2
3.get数组值[]

hive> select  get_json_object(data, '$.store.fruit[0]') from test;
结果：{"weight":8,"type":"apple"}


https://www.jb51.net/article/255911.htm

存储的数据格式（字段名 people_json）：

1`[{“name”: “zhangsan”, “age”: “13”, “gender”: “男”}]`

代码如下（示例）：1

`select` `*` `from` `table_name`  `where` `people_json->``'$[*].name'` `like` `'%zhang%'`

1

`select` `*` `from` `table_name`  `where` `JSON_CONTAINS(people_json,JSON_OBJECT(``'age'``,` `"13"``))`


### 行列转换 explode
https://blog.csdn.net/Abysscarry/article/details/81505953

列转行：
select *,task_sub_target 
from odm.odm_inn_molo_martech_task_info_pre_i_d
lateral view explode(split(task_target_ext,',')) t as task_sub_target
where dt='2022-01-23'


取最小一条数据：min(named_struct('consumerdate',consumerdate,'orderid',orderid))，相当于row_number() over (order by xx asc) 
取最大一条数据：max(named_struct('client_tm',client_tm,'chnl_code',chnl_code)) as struct1，相当于row_number() over (order by xx desc)



行转列
把相同user_id的order_id按照逗号转为一行
select user_id,
concat_ws(',',collect_list(order_id)) as order_value
from col_lie
group by user_id
使用函数：concat_ws(',',collect_set(column))  
说明：collect_list 不去重，collect_set 去重。


最大值：greatest(value1,value2,value3,...) value不能为空，否则函数返回null
最小值：least(value1,value2,value3,...) value不能为空，否则函数返回null
字段长度：size(split(t2_value,'_')) = 2


再分享几个常用的函数，比如取dt，有时候历史数据没有某些dt，可以用dt=greatest(sysdate(-1),'2022-01-01')，这样22年以前补数均用'2022-01-01'的dt数据



### 多层分区
partition(key1,key2)
https://blog.51cto.com/u_14582976/2829059
https://blog.csdn.net/qq_32727095/article/details/107770782


### On 1=1

unconditional join 
It's simply doing a cross join, which selects all rows from the first table and all rows from the second table and shows as cartesian product, i.e. with all possibilities.
JOIN (LEFT, INNER, RIGHT, etc.) statements normally require an 'ON ..." condition. Putting in 1=1 is like saying "1=1 is always true, do don't eliminate anything".


### 复杂数据格式
https://support.huaweicloud.com/sqlref-spark-dli/dli_08_0059.html


### 正则表达式
正则表达式操作：https://blog.csdn.net/weixin_40983094/article/details/108452883
udf：https://blog.csdn.net/qq_39437513/article/details/119902071
正则表达式教程：https://www.runoob.com/regexp/regexp-syntax.html

### 转义符问题

https://cf.jd.com/pages/viewpage.action?pageId=287925237

**  
现象：**用户在直接sql环境、数据查询、开发平台IDE、调度脚本里，使用regexp_replace函数作转义时，对脚本里写几个“\”搞不清，一直调试不成功。

**影响：**用户调试脚本涉及转义时，对“\”到底写几个拿捏不准，试了多次一直报错，影响开发效率

**原因**：不同环境有单独的转义符解析，一般有这几层环境： 调度解析、hive -e引发的hive环境原始解析、开发平台IDE的解析、数据查询的解析等

**解决方案：**

1、简单识别自己的sql经过几层环境，每多一层环境“\”个数就翻倍：

        举例：通过直接hive环境调试无误的sql，如果要放到调度脚本，你的“\”还会经历 hive -e解析、调度解析，多了两层，你的“\”数量就要乘4

   2、快速调试

      最小单位去调试：直接在所处环境,拿报错的那个字段的具体的值，仅调试“正则表达式”，不要去执行整个sql，如下：

          select  regexp_replace(**${pf_addcart_nobuy_sku_top20_d365}**, ' ', ''), '\\[|\\]', '') ;    ##没错，就是调试这么短，连from都不用写！

        **${pf_addcart_nobuy_sku_top20_d365}:  这里替换成真实的值，如下：**

         **select  regexp_replace('[aa]bbb]xx]', ' ', ''), '\\[|\\]', '') ;**     

经验： 一般直接在sql里写1个“\”,在数据查询/开发平台IDE里的sql写2个,在调度环境写 4个， 快速调试一下吧


### 排序

https://www.51cto.com/article/700564.html
RANK()、DENSE_RANK()与ROW_NUMBER()三者的差异

NTILE(n)将分区中的有序数据分为n个等级，记录等级数
`NTILE(buckets) OVER ( [PARTITION BY partition_expression, ... ] ORDER BY sort_expression [ASC | DESC], ... ) //更多请阅读：https://www.yiibai.com/sqlserver/sql-server-ntile-function.html`


- 分布函数有两个PERCENT_RANK()和CUME_DIST()
	- PERCENT_RANK()的用途是每行按照公式(rank-1) / (rows-1)进行计算。其中，rank为RANK()函数产生的序号，rows为当前窗口的记录总行数。
	- CUME_DIST()的用途是分组内小于、等于当前rank值的行数 / 分组内总行数。



sql分位数取法：
@林国涵  @安珂敏  
select percentile_approx(benjin,array(0.01,0.25,0.5,0.75,0.99),9999)


### group by  为null的键
[(4条消息) Mysql GROUP BY 排除null数据_mysql group by null_Crystalqy的博客-CSDN博客](https://blog.csdn.net/Crystalqy/article/details/114086528)
groupby为null的键
t1 left join t2 on t1.actv_id=t2.actv_id （t1 为领取，t2 为转化）
如 group by t1.actv_id  没问题；group by t2.actv_id  没问题