## 逻辑语句

### Not in
CALCULATE (
    [total valid spend],
    FILTER ( payments, paymentypeid = 7 && paymentprocessorID IN { 1, 5, 6, 9 } )
)

```dax

NOT_DAX =
CALCULATE(
SUM('Global-Superstore'[Sales]),
FILTER('Global-Superstore',
NOT('Global-Superstore'[Region]) IN {"Africa", "Canada", "Caribbean"}
))


CALCULATE(
sum('data'[lsxy]),
FILTER('data',
NOT ('data'[user_lvl_code])  in {1,2}
))


```

### DAX


SWITCH (  
[auth_flag],  
0, "否",  
1, "是"
)  

SWITCH (  
[bangka_flag],   
1, "是",
"否"
)  

=sumx('表1','表1'[net_cnsm_amount]/switch('表1'[time_label],"01:前",35,"02:中",29,"03:后",21))

commit -a 
  
--------------------------  
© 版权声明：本文为Power BI极客原创文章，著作权归作者所有  
商业转载请联系作者获得授权，非商业转载请注明出处。  
源地址：https://www.powerbigeek.com/dax-functions-switch/?f=1
https://zhuanlan.zhihu.com/p/60560969

## 变量

[官网教程文档](https://learn.microsoft.com/zh-cn/dax/best-practices/dax-variables)
语法：
VAR的语法规范很简单，就是把一个表达式定义为一个名称，  在后续的公式被引用，但是作用域只在当前度量值内
> VAR 变量名=表达式
> ......
> RETURN
> 

#### 在度量值中的编辑格式
[Youtube 教程](https://www.youtube.com/watch?v=wpcruPBpj2c)
``` sql

--例1：
=  -- 一定要把等号放在前面不要加冒号
VAR weight= sumx('损益','损益'[net_fq_jy])/sumx('损益','损益'[net_jy])
VAR term=sumx('损益','损益'[sum_fq_term])/sumx('损益','损益'[net_fq_jy])

--例2：
=
VAR SalesAmount =
SUMX (
Sales,
Sales[Quantity] * Sales[Net Price]
)
RETURN
DIVIDE (
SalesAmount,
CALCULATE (
SalesAmount,
ALL ( Product ))

)

```


#### 迭代和汇总函数
sum() & sumx( ) 的使用场景
```DAX
Subcategory Sales Rank =
COUNTROWS(
    FILTER(
        Subcategory,
        EARLIER(Subcategory[Subcategory Sales]) < Subcategory[Subcategory Sales]
    )
) + 1

--改成变量写法
Subcategory Sales Rank =
VAR CurrentSubcategorySales = Subcategory[Subcategory Sales]
RETURN
    COUNTROWS(
        FILTER(
            Subcategory,
            CurrentSubcategorySales < Subcategory[Subcategory Sales]
        )
    ) + 1


```


## 条件语句


## 增删改基本语法


