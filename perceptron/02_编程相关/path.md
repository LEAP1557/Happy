### 0306
dataframe slice
group by  count distinct
临时变量表 
if 条件 
最后对比
plot  LTV


#### Series& DataFrame基本属性

DataFrame 对于行列 index， columns  本质都是series化处理，只不过用不同的命名来区分；

-   Series 数据结构的常用属性；
	- index
		value<u>s</u>
		index.name  values.name
		ndim
-   Series 数据结构的常用操作方法；
- Dataframe
	- 属性多列size

#### **查询**
loc() 的查询条件，可以使用label值，也可以使用布尔值，他丰富的传值方式，以及简洁的使用方式，成为 Pandas 数据查询较为常用的方法。
.iloc（）  --index  imbeded

行，列必须按照此顺序 
单元格`print(data.loc[1,"价格"])
区间`print(data.loc[0:5,["编程语言","价格"]])`
条件
 - `print(data.loc[data["价格"]<60])`
 - `print(data.loc[(data["价格"]<=69.9) & (data["推出时间"]=="1972年") ]))`
 函数  
 - `print(data.loc[data["推出时间"].isin(["1972年","1995年","1983年"])])


#### 修改
<u>rename 函数修改索引值</u>
 `rename(self, mapper=None, index=None, columns=None, axis=None, copy=True, inplace=False, level=None, errors=‘ignore’)

mapper  映射关系（字典或者函数），
axis  表示修改行索引（axis=0 默认）还是列索引（axis=1）
index，columns  只针对单独元素修改


<u>修改数据</u>
修改单个数据 t[]、iat[]、loc[]、iloc[]
修改某类数 replace(to_replace=None,value=None……）
修改区域  `python  data.iloc[[0,1]]=data_new
修改列  `python  data.iloc[:,[1]]=new_series


#### 算术运算

- add () 函数根据索引值，对相同索引的数据进行加法运算，注意字符串的加法是拼接操作。
- sub () 函数用于数据集之间对应索引的减法操作，该操作不同于加法操作，字符操作是不存在减法操作的，算术上的减法只用于数值类型的数据运算，包括整形、浮点型等
- mul () 操作是两个数据集对应索引列的数据进行乘法运算，该函数同样只适用于两个数值数据的运算，字符串之间，字符串与数值之间进行乘法运算均会报错。
- div () 函数用于两个数据集对应索引列的数据进行除法运算，该函数同样只适用数值型数据之间的运算，并且除数不能为 0 ，否则会报错。


#### 数据拼接联合
连接 merge()   横向
合并  concat()  纵向

##### 连接 merge()
``` python

pd.merge(left, right, how='inner', on=None, left_on=None, right_on=None,
         left_index=False, right_index=False, sort=True,
         suffixes=('_x', '_y'), copy=True, indicator=False,
         validate=None)
```
```


```

**how** 参数
该参数有四个值:
-   inner：是默认的匹配方式，根据两个表的交集部分进行匹配连接；
-   left：以左边的数据表为基础，匹配右边的数据表，匹配不到的通过 NaN 进行填充；
-   right：以右边的数据表为基础，匹配左边的数据表，匹配不到的通过 NaN 进行填充；
-   outer：将两个数据表连接汇总成一个表，有匹配的展示结果，没有匹配的填充 NaN。

on 参数该参数用于指定数据集的连接键，默认的是两个数据集中共有的列索引，就像我们上面的 data_01 和 data_02 数据集，他们都有 “编号” 和 “推出时间” 列，因此这两列就是默认的连接键。当然我们也可以用 on 参数指定其中的一列为连接键，如下代码演示：

**suffixes** 参数
该参数用于指定连接后数据集中重复列索引的后缀，默认的是（‘x’,‘y’）：



##### 合并  concat()

```python

pd.concat(objs, axis='0', join:'outer', ignore_index: 'False', keys='None', levels='None', names='None', verify_integrity: 'False', sort: 'False', copy:'True') 

```


**axis** 参数  该参数用于设置数据合并的方向。axis=0 纵向合并 (默认)，axis=1 横向合并
**join** 参数该参数设置数据集合并的方式，有两个值：
-   inner：数据集之间的交集，行合并时取列索引值的相同的数据，列合并时取行索引值相同的数据；
-   outer：取数据集之间的并集，没有数据的用 NaN 进行填充，默认是这种合并方式。
 ignore_index 参数该参数可以设置在合并方向上的索引值自动生成，从 0 开始的整数序列。


#### 排序

sort_index() 函数  按索引排序
sort_values() 函数  数值排序

##### sort_index() 函数
```python

df.sort_index(axis=0, level=None, ascending=True, inplace=False, kind='quicksort', na_position='last', sort_remaining=True, ignore_index=False, key=None)


# 2.按列索引进行降序排列 axis=1,ascending=False
data_res=data.sort_index(axis=1,ascending=False)

ascending=True 升序或是 ascending=False 降序排序
排序的索引轴，axis=0 行索引（默认），axis=1 列索引

```



#### sort_values() 函数

- by 指定需要排序的列或者行
- axis 指定需要排序的是列还是行，默认 axis=0 表示行
- na_position  设置缺失值显示的位置，有 first 和 last 两个值，默认是 last

```python

pd.sort_values(by, axis=0, ascending=True, inplace=False, kind='quicksort', na_position='last', ignore_index=False, key=None)



# 2.按 DD 列进行 行数据的 降序 排序
data_res=data.sort_values(by=["DD"],ascending=False,axis=0)



# 3.na_position='first' 参数 ，按 DD 列进行 行数据的 降序 排序
data_res=data.sort_values(by=["DD"],ascending=False,axis=0,na_position='first')

通过设置 na_position='first' 缺失值放在了开始位置。


# 4.设置axis=1，以行为判断标准进行列排序
data_res=data.sort_values(by=[3],ascending=False,axis=1)
```

##### rank()  排名
排名操作是根据数据的大小，判断出该数据在数据集中的名次，默认是从 1 开始一直到数据中有效数据的长度，如果存在重复数据，则会求出这几个数据的平均排名。Pandas 库中针对排名操作提供了方便的操作函数 rank () .

method  用于平级数据，也就是要排名的数据中，他们的大小是一样的，这种平级的数据有四种排名的方式：

-   average：在一组相等的排名数据中，为每个数据取他们的平均排名；
-   min：在一组相等的排名数据中，使用最小的排名给每个数据；
-   max：在一组相等的排名数据中，使用最大的排名给每个数据；
-   first：在一组相等的排名数据中，按各个值在原始数据中的出现顺序进行排名。
```python
df.rank(axis=0, method='average', numeric_only=None, na_option='keep', ascending=True, pct=False)
```


####   层次化索引

层次化索引是 Pandas 的一个重要功能，是指在一个轴上有至少两个级别的索引值，层次化索引的好处是我们**可以方便的使用低纬度索引形式去表示高纬度的数据**，下面我们看一下层次化索引的具体数据表现：

##### 格式
类似于透视表
	index=`[[ xx],[ xx]]`      两层索引，头一个索引包含重复项
	column  也可以  操作同理
```python
# 2. 构造了一个 DataFrame 数据集
df1=pd.DataFrame([[96,92,83,94],[85,86,77,88],[69,90,91,82],[83,84,85,86],[83,84,85,86],[83,84,85,86]],index=[['2018年','2018年','2018年','2019年','2019年','2019年'],['语文','数学','英语','语文','数学','英语']],columns=[['上学期','上学期','下学期','下学期'],['期中考试','期末考试','期中考试','期末考试']])
print(df1)
# --- 输出结果 ---
            上学期          下学期     
          	期中考试 期末考试 期中考试 期末考试
2018年  语文   96   	92    83     94
      	数学   85   	86     77     88
      	英语   69   	90     91     82
2019年  语文   83      84    85     86
      	数学   83  	 84    85     86
      	英语   83  	 84    85     86
# 结果解析：这里我们构造了一个 DataFrame 数据集，在行索引和列索引我们均设置了层次化的索引，这样能更加有效的表示高纬度的数据。
```


##### 选取操作
对于 Pandas 库数据集具有多层索引值，我们可以对一级索引通过 loc () 函数获取数据子集：

注意 索引层级  和普通的列名不同
```python
# df1 原数据集，是上面我们自己创建的具有两层列索引和两层行索引的数据集
print(df1.loc['2018年','上学期'])
# --- 输出结果 ---
    期中考试 期末考试
语文	 96	    92
数学	 85	    86
英语	 69	    90
# 结果解析：我们通过 loc() 函数传入行和列的一级索引，可以看到得到了一个 DataFrame 数据子集

print(df1.loc[:,'上学期'])
# --- 输出结果 ---
             期中考试	期末考试
2018年	语文	  96	 92
         数学	   85	 86
         英语	   69	 90
2019年	语文	  83	84
         数学	  83	 84
         英语	  83	 84
# 结果解析：这里我们获取了列索引中的上学期的子集，可以看到输出结果中行索引还是两级索引
```



#### 数据重塑  （针对多层索引）

Pandas 对应数据的重塑有三种操作方式，分别为重塑操作 stack () ， unstack () 和轴向旋转操作 pivot ()：

##### stack  和 unstack


-   stack ()：该操作是将数据的列 “旋转” 为行；  stack 起来变高
-   unstack ()：该操作是将数据的行 “旋转” 为列。unstack 下去变矮
- 二者互为逆操作
```python
print(df_data.stack().unstack())
# --- 输出结果 ---
模考  月考1  月考2  月考3  月考4
科目                    
语文   96   92   83   94
数学   85   86   77   88
英语   69   90   91   82
```


##### Pivot
该函数用于指定行索引，列索引，以及数据值，生成一个 “pivot” 数据表格。该函数有三个参数：

```python
df_data_pivot=pd.DataFrame([["2018","上学期",83,94],["2018","下学期",77,88],
                            ["2019","上学期",83,94],["2019","下学期",83,94],
                            ["2020","上学期",83,94],["2020","下学期",91,82]],
                 index=['a','b','c','d','e','f'],
                 columns=['年度','学期','语文','数学'])
print(df_data_pivot)

# --- 输出结果 ---
     年度   学期  语文  数学
a  2018  上学期  83  94
b  2018  下学期  77  88
c  2019  上学期  83  94
d  2019  下学期  83  94
e  2020  上学期  83  94
f  2020  下学期  91  82


# pivot(index="年度", columns="学期", values="语文")
new_df=df_data_pivot.pivot(index="年度", columns="学期", values="语文")
print(new_df)
# --- 输出结果 ---
学期    上学期  下学期
年度            
2018   83   77
2019   83   83
2020   83   91
```


#### 分组聚合操作

##### 分组groupby
Pandas 中的分组操作主要通过函数 groupby () 实现，该函数对数据进行分组，并不会产生运算，分组后会返回一个<u> groupby 对象</u>，该对象并不能展示数据，要通过具体的操作函数才能看到数据结果。



实战中多是多层groupby    所以最好把 as_index 变成False
groupby () 函数中的一个参数：as_index ，该参数默认为 True，是用来指定是否用分组索引作为聚合结果数据集的行索引，上面的代码中，默认 as_index=True ，因此行索引会有两层，分别为技术方向和推出时间，下面我们通过指定 as_index=False , 默认行索引会从 0 开始生成序列：

##### 聚合

1. **sum()** 函数
该函数用于求各组数值数据的和，非数值数据不进行该聚合操作。
2. **count()** 函数
该函数用于计算分组后各组数据的数量。
3. **mean()** 函数
该函数用于进行各分组数据的平均值的计算，该函数只对数值数据进行聚合。

```python
# 指定 as_index=False
data.groupby(['技术方向','推出时间'],as_index=False).sum()



data.groupby(['技术方向','推出时间'],as_index=False)['编程语言','年均销售数量','价格'].count()
# --- 输出结果 ---
```


##### agg
执行多种函数

``` python
import numpy as np
import pandas as pd
pop=pd.read_excel('GDPandPopulation.xlsx',sheet_name='Population',index_col=0)
gdp=pd.read_excel('GDPandPopulation.xlsx',sheet_name='GDP',index_col=0)
df5=pd.concat([pop,gdp],axis=0,keys=['pop','gdp'])  #不用改名字即可合并
df6=pop.join(gdp,lsuffix='_pop', rsuffix='_gdp') #两个dataframe列名相同，需要加lsuffix或rsuffix在左边/右边的列名上加后缀来区分
region=pd.read_excel('GDPandPopulation.xlsx',sheet_name='region',index_col=0)
df7=df6.join(region) #没有重名列可以直接使用
group_region=df7.groupby(by='区域')  #以'区域'这一列进行分类，值相同的行被并为一类
print(group_region[['2018年_pop','2018年_gdp']].agg([np.mean,np.max]))  #可以让一列或多列执行一个或多个函数

```


##### apply


##### transform
占比

```python
import numpy as np
import pandas as pd
pop=pd.read_excel('GDPandPopulation.xlsx',sheet_name='Population',index_col=0)
gdp=pd.read_excel('GDPandPopulation.xlsx',sheet_name='GDP',index_col=0)
df5=pd.concat([pop,gdp],axis=0,keys=['pop','gdp'])  #不用改名字即可合并
df6=pop.join(gdp,lsuffix='_pop', rsuffix='_gdp') #两个dataframe列名相同，需要加lsuffix或rsuffix在左边/右边的列名上加后缀来区分
region=pd.read_excel('GDPandPopulation.xlsx',sheet_name='region',index_col=0)
df7=df6.join(region) #没有重名列可以直接使用
group_region=df7.groupby(by='区域')  #以'区域'这一列进行分类，值相同的行被并为一类
groupsum=group_region.transform(np.sum)
df7['gdp占区域比例']=df7['2018年_gdp']/ groupsum['2018年_gdp']
print(df7)


```


#### pivot_table function
[知乎示例](https://zhuanlan.zhihu.com/p/552332233)

-   data:数据集
-   values:要聚合的列，默认情况下对所有数值型变量聚合
-   index:要在数据透视表上分组的变量，可设置多个列，实现多层分组
-   columns:要在数据透视表上分组的变量，注意其每个取值作为1列，实现“长表”转化为“宽表”
-   aggfunc: 对values进行计算，默认为np.mean
-   fill_value:要用来替换缺失值的值（在聚合后生成的数据透视表中）。
-   sort: 布尔型，默认True. 是否将结果排序

前5个参数最常用，index相当于数据透视表的“行”或理解为数据透视表的key,可以有多个key；values相当于数据透视表的“列”；columns相当于把列再进一步细分，也是实现“长表”转“宽表”的关键；aggfunc是对聚合在i行j列的n个数据进行运算。多层嵌套：多个index组合可实现“行”的多层分类；values+columns组合可实现“列”的多层分类。


> 官网说明：[pandas.pivot_table — pandas 1.4.3 documentation (pydata.org)](https://link.zhihu.com/?target=https%3A//pandas.pydata.org/pandas-docs/stable/reference/api/pandas.pivot_table.html)  
> 学习资料：莫烦Python:[https://mofanpy.com](https://link.zhihu.com/?target=https%3A//mofanpy.com) ( Numpy&Pandas视频课)




行动路径思路；--> 相应code
日数据
time 模块时间序列
整理日指标






功能：
- 周期趋势呈现业绩
	- 可视化图表
	- 现状表述--直接输出语句
- 预测  ： prophet --> 可行性低
- 异常波动判定
	- 判定逻辑：参考网上资料，储存在公司电脑
	- 实施
		- 指标加工，排序， lambda
		- 条件语句
	- 邮件触达
- 品类相关  
	- 判定逻辑
		- 商城
		- 白条
		- 渗透率
		- 相对数值
			- 占全盘比
			- 距均值差值
	- 运营逻辑
		- 盘子-交易额
		- sku集中度，商家集中度  （完全竞争市场，寡头市场）
	- 品类营销判定--难
		-  和coupon表关联
		- 参考CAPM 进行评价
	- 操作逻辑
		- 历史数据，发现规律，发现趋势
		- 沉淀经验数据
		- 条件判断异常情况
		- 发展评价逻辑  
- 不同指标相关，因果，互相影响？
	- 可视化看规律
	- 思路参考原则
- 指标衍生逻辑：环比、同比 、移动平均环比同比
- 差异度判定：
	- Variance
	- 熵



自己的时限还是需要拉长一些看

语法重新熟悉
lamba
def  语句学习
条件，判断， 整列加减乘除



收入
息费
通道收入
B端收入（忘记是否有前置code了）
资金成本（ 交易折算 ）
通道成本  （交易折算）
首单费用
期间费用
参数：分期占比、付费分期占比、付费分期人数  、 拆交易月份


风险成本（同样分区满足）--单独出



--------
### 0301
问题：range（） 数据类型？



目标：
量化交易编程技能基础
系统邮件生成流程 code
https://www.runoob.com/python3/python3-smtp.html
http://www.imooc.com/wiki/officeautomation/htmlandannex.html

推导式这种方式能都快速帮我们生成我们想要的列表，集合或者字典等等。极大的加快了我们的开发速度。假如你是一位测试人员，需要大量的假数据来测试程序，这个时候推导式这种方式就很适合你。
这节课我们学习了函数的参数，参数这个概念是函数使用中不可缺少的一环。在函数定义时的参数叫做"形参"，而在函数调用时的参数叫做"实参"。一定要分清这两个概念。
  

迭代是Python最强大的功能之一，是访问集合元素的一种方式。
迭代器是一个可以记住遍历的位置的对象。
迭代器对象从集合的第一个元素开始访问，直到所有的元素被访问完结束。迭代器只能往前不会后退。
迭代器有两个基本的方法：**iter()** 和 **next()**。
字符串，列表或元组对象都可用于创建迭代器
迭代器对象可以使用常规for语句进行遍历：

在 Python 中，使用了 yield 的函数被称为生成器（generator）。
跟普通函数不同的是，**生成器是一个返回迭代器的函数**，只能用于迭代操作，更简单点理解生成器就是一个迭代器。

交互式编程和脚本式编程
- 数据格式
- 逻辑
	- 循环语句
	- for 语句
- 推导式--更快输入
	- 格式
	- if 条件函数筛选 （无else）
	- for 循环嵌套
		- 单独装饰器
		- 双for  append
	- for+ if： 先for 后if
	- 列表 、集合、字典
- 函数定义--重复化逻辑固化
- 函数参数
	- 默认、可变、关键字
	- 实参和形参
- [面向对象逻辑 ](https://www.runoob.com/python3/python3-class.html)
	*  ***类(Class):** 用来描述具有相同的属性和方法的对象的集合。它定义了该集合中每个对象所共有的属性和方法。对象是类的实例。
		* 属性 x.i
		* 方法  x.f()
			* 类有一个名为 `__init__() `的特殊方法（**构造方法**），该方法在<u>类实例化</u>时会自动调用 x = MyClass()
	-   **方法**:  类中定义的函数。
	-   **类变量**：类变量在整个实例化的对象中是公用的。类变量定义在类中且在函数体之外。类变量通常不作为实例变量使用。
	- **实例变量**：在类的声明中，属性是用变量来表示的，这种变量就称为实例变量，实例变量就是一个用 self 修饰的变量。
	-   **数据成员**：类变量或者实例变量用于处理类及其实例对象的相关的数据。
	-   **方法重写**：如果从父类继承的方法不能满足子类的需求，可以对其进行改写，这个过程叫方法的覆盖（override），也称为方法的重写。
	-   **局部变量**：定义在方法中的变量，只作用于当前实例的类。
	-  继承：即一个派生类（derived class）继承基类（base class）的字段和方法。继承也允许把一个派生类的对象作为一个基类对象对待。例如，有这样一个设计：一个Dog类型的对象派生自Animal类，这是模拟"是一个（is-a）"关系（例图，Dog是一个Animal）。
	-   实例化：创建一个类的实例，类的具体对象
	- <u> 对象：通过类定义的数据结构实例。对象包括两个数据成员（类变量和实例变量）和方法。</u>
- 命名空间和作用域  
	- 命名空间**局部的命名空间 -> 全局命名空间 -> 内置命名空间**。
		-   **内置名称（built-in names**）， Python 语言内置的名称，比如函数名 abs、char 和异常名称 BaseException、Exception 等等。
		-   **全局名称（global names）**，模块中定义的名称，记录了模块的变量，包括函数、类、其它导入的模块、模块级的变量和常量。
		-   **局部名称（local names）**，函数中定义的名称，记录了函数的变量，包括函数的参数和局部定义的变量。（类中定义的也是）
	- 作用域  **L –> E –> G –> B**。
		- -   **L（Local）**：最内层，包含局部变量，比如一个函数/方法内部。
		-   **E（Enclosing）**：包含了非局部(non-local)也非全局(non-global)的变量。比如两个嵌套函数，一个函数（或类） A 里面又包含了一个函数 B ，那么对于 B 中的名称来说 A 中的作用域就为 nonlocal。
		-   **G（Global）**：当前脚本的最外层，比如当前模块的全局变量。
		-   **B（Built-in）**： 包含了内建的变量/关键字等，最后被搜索。
	- 全局变量和局部变量
	- global & nonlocal 关键字
		- 函数外  global
		- 嵌套作用域 enclosing 作用域   nonlocal
- 标准库概览
	- ·os 模块
	- math 模块
	- global 模块
	- urllib.request 以及用于发送电子邮件的 smtplib 模块
	- datetime模块为日期和时间处理同时提供了简单和复杂的方法。
- 其他系统知识
	- 输入和输出  read & write
	- 输入和输出
		- file 对象使用 open 函数来创建，下表列出了 file 对象常用的方法
		- Python open() 方法用于打开一个文件，并返回文件对象。
		- 使用 open() 方法一定要保证关闭文件对象，即调用 close() 方法。
		- open() 函数常用形式是接收两个参数：文件名(file)和模式(mode)。
	- OS  文件/目录
		- **os** 模块提供了非常丰富的方法用来处理文件和目录
	- 错误和异常探索
		- 异常捕捉： try   / except
		- try/except...else
			- 语句还有一个可选的 **else** 子句，如果使用这个子句，那么必须放在所有的 except 子句之后。else 子句将在 try 子句没有发生任何异常的时候执行。
		- try -finally  语句无论是否发生异常都执行最后的代码
		- raise 抛出制定异常
	- 



- 模块
- 编程范式
- 

- 择时选股原理
	3.构建金融数据库
		3.1 构建金融数据库
		3.2 实战案例
	4.择时策略
		4.1 量化择时策略
		4.2 研报策略复现
	5.选股策略
		5.1 量化选股策略
		5.2 研报策略复现
- 多种策略
	- 1 择时策略
	- 美债择时
	- 策略评价
	2 选股策略
	- 因子构造
	- 因子分析
	- 多因子选股
	3 选股带择时策略



#### 类的方法
```python

__下划线都代表特殊情况
#类定义 
class people: 
	#定义基本属性 
	name = '' 
	age = 0 
	#定义私有属性,私有属性在类外部无法直接进行访问
	 __weight = 0 
	 #定义构造方法  里面是构造属性
	  def __init__(self,n,a,w): 
		  self.name = n 
		  self.age = a 
		  self.__weight = w 
	  def speak(self): 
		  print("%s 说: 我 %d 岁。" %(self.name,self.age)) 
		  # 实例化类 
	  p = people('runoob',10,30) p.speak()




```








#### 继承
普通继承
多重继承
方法重写



#### [类和方法](https://www.runoob.com/python3/python3-class.html)
<u>类的私有属性</u>
**__private_attrs**：两个下划线开头，声明该属性为私有，不能在类的外部被使用或直接访问。在类内部的方法中使用时 **self.__private_attrs**。

<u>类的方法</u>
在类的内部，使用 def 关键字来定义一个方法，与一般函数定义不同，类方法必须包含参数 self，且为第一个参数，self 代表的是类的实例。
self 的名字并不是规定死的，也可以使用 this，但是最好还是按照约定使用 self。

<u>类的私有方法</u>
**__private_method**：两个下划线开头，声明该方法为私有方法，只能在类的内部调用 ，不能在类的外部调用。**self.__private_methods**。


<u>类的专有方法：</u>
-   **__init__ :** 构造函数，在生成对象时调用
-   **__del__ :** 析构函数，释放对象时使用
-   **__repr__ :** 打印，转换
-   **__setitem__ :** 按照索引赋值
-   **__getitem__:** 按照索引获取值
-   **__len__:** 获得长度



#### 作用域

```python
g_count = 0  # 全局作用域
def outer():
    o_count = 1  # 闭包函数外的函数中
    def inner():
        i_count = 2  # 局部作用域

	```


![[Pasted image 20230302044503.png]]\


Python 中只有**模块（module），类（class）以及函数（def、lambda）**
才会引入新的作用域，其它的代码块**如 if/elif/else/、try/except、for/while等** 是不会引入新的作用域的，也就是说这些语句内定义的变量，外部也可以访问，如下代码：
```python


>>> def test():
...     msg_inner = 'I am from Runoob'
... 
>>> msg_inner
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
NameError: name 'msg_inner' is not defined



>>> if True:
...  msg = 'I am from Runoob'
... 
>>> msg
'I am from Runoob'
>>>

```



global 和 nonlocal  关键字

```python


num = 1 
def fun1(): 
    global num # 需要使用 global 关键字声明 
    print(num) 
    num = 123 p
    rint(num) 
    
fun1() 
print(num)


# 如果要修改嵌套作用域（enclosing 作用域，外层非全局作用域）中的变量则需要 nonlocal 关键字了

def outer(): 
		num = 10 
		def inner(): 
			nonlocal num # nonlocal关键字声明 
			num = 100 
			print(num) 
		inner() 
		print(num) 
outer()
```


> -  想象对表格的操作过程，
	目测有循环语句
	numpy的 broadcast

steps：
基础元素+操作
设计流程
按图索骥
范围品类 + MOB

dataframe  和series 之间的运算
pivot 多层索引   slice切片
pandas  多层索引
- 参考 [层次化索引](http://www.imooc.com/wiki/pandasless/hierarchicalindex.html)
pandas pivot函数
[官方文档](https://pandas.pydata.org/pandas-docs/stable/reference/api/pandas.pivot_table.html)
[他人笔记](https://blog.csdn.net/DiAsdream/article/details/124889380)


函数 def  return 和print的区别
``
```python
list = [1, -1, 2, -2, 3, -3]

def select_positive(x):
    return x > 0

def select_negative(x):
    return x < 0

def select(list, select_function):
    for item in list:
        if select_function(item):
            print(item)

select(list, select_positive)
select(list, select_negative)

```



#### Pivot
python——pivot_table，groupby - luckysusan1991的文章 - 知乎 https://zhuanlan.zhihu.com/p/50804981

从Excel到Python：最常用的36个Pandas函数！最完整的Pandas教程！ - 一枚程序媛的文章 - 知乎 https://zhuanlan.zhihu.com/p/97617276


Pandas | 一文看懂透视表pivot_table - rain的文章 - 知乎 https://zhuanlan.zhihu.com/p/31952948




用Python实现excel 14个常用操作 - 小匿的文章 - 知乎 https://zhuanlan.zhihu.com/p/30072060


#### 列表


#### 元组


#### 集合


#### 字典


