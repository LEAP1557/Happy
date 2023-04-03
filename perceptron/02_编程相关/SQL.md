

### 窗口函数 sum() over()
http://lxw1234.com/archives/2015/04/176.htm
- 分组全部加总 SUM(pv) OVER(PARTITION BY cookieid) AS pv3
-  分组顺序累加 1.  SUM(pv) OVER(PARTITION BY cookieid ORDER BY createtime) AS pv1, -- 默认为从起点到当前行


### Get_json
SELECT get_json_object('{"a":"b"}', '$.a');
https://docs.databricks.com/sql/language-manual/functions/get_json_object.html


### 多层分区
partition(key1,key2)
https://blog.51cto.com/u_14582976/2829059
https://blog.csdn.net/qq_32727095/article/details/107770782


### On 1=1

unconditional join 
It's simply doing a cross join, which selects all rows from the first table and all rows from the second table and shows as cartesian product, i.e. with all possibilities.
JOIN (LEFT, INNER, RIGHT, etc.) statements normally require an 'ON ..." condition. Putting in 1=1 is like saying "1=1 is always true, do don't eliminate anything".