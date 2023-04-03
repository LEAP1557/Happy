

## Groupby 
[知乎groupby 最清楚的教程](https://zhuanlan.zhihu.com/p/101284491)


- group by实质效果  多个dataframe


### agg
- agg（ 字典传参，加工grouped  df ， 然后返回 group结果）
```python
In [17]: data.groupby('company').agg({'salary':'median','age':'mean'})
```

	### apply
- apply  用apply  操作grouped  的df  具有更高的灵活度，结果和agg功能一致

```python
In [38]: def get_oldest_staff(x):
    ...:     df = x.sort_values(by = 'age',ascending=True)
    ...:     return df.iloc[-1,:]
    ...:
​
In [39]: oldest_staff = data.groupby('company',as_index=False).apply(get_oldest_staff)
​
```

### agg  重命名
使用pandas [groupby](https://so.csdn.net/so/search?q=groupby&spm=1001.2101.3001.7020)对多列进行计算(包含使用lambda函数的情况)后自动重命名

```python
result = df.groupby('col1').agg(
        speed_avg=('speed', 'mean'), speed_min=('speed', 'min'), speed_max=('speed', 'max'),vol=('Id', 'size'),spread=('speed',lambda x:max(x)-min(x)).reset_index()

```


[原文链接](https://blog.csdn.net/superfjj/article/details/118667826)
```python
可以同时指定多个聚合方法：

In [81]: grouped = df.groupby("A")

In [82]: grouped["C"].agg([np.sum, np.mean, np.std])
Out[82]: 
          sum      mean       std
A                                
bar  0.392940  0.130980  0.181231
foo -1.796421 -0.359284  0.912265


可以重命名：

In [84]: (
   ....:     grouped["C"]
   ....:     .agg([np.sum, np.mean, np.std])
   ....:     .rename(columns={"sum": "foo", "mean": "bar", "std": "baz"})
   ....: )
   ....: 
Out[84]: 
          foo       bar       baz
A                                
bar  0.392940  0.130980  0.181231
foo -1.796421 -0.359284  0.912265
1



NamedAgg
NamedAgg 可以对聚合进行更精准的定义，它包含 column 和aggfunc 两个定制化的字段。

In [88]: animals = pd.DataFrame(
   ....:     {
   ....:         "kind": ["cat", "dog", "cat", "dog"],
   ....:         "height": [9.1, 6.0, 9.5, 34.0],
   ....:         "weight": [7.9, 7.5, 9.9, 198.0],
   ....:     }
   ....: )
   ....: 

In [89]: animals
Out[89]: 
  kind  height  weight
0  cat     9.1     7.9
1  dog     6.0     7.5
2  cat     9.5     9.9
3  dog    34.0   198.0

In [90]: animals.groupby("kind").agg(
   ....:     min_height=pd.NamedAgg(column="height", aggfunc="min"),
   ....:     max_height=pd.NamedAgg(column="height", aggfunc="max"),
   ....:     average_weight=pd.NamedAgg(column="weight", aggfunc=np.mean),
   ....: )
   ....: 
Out[90]: 
      min_height  max_height  average_weight
kind                                        
cat          9.1         9.5            8.90
dog          6.0        34.0          102.75


或者直接使用一个元组：

In [91]: animals.groupby("kind").agg(
   ....:     min_height=("height", "min"),
   ....:     max_height=("height", "max"),
   ....:     average_weight=("weight", np.mean),
   ....: )
   ....: 
Out[91]: 
      min_height  max_height  average_weight
kind                                        
cat          9.1         9.5            8.90
dog          6.0        34.0          102.75


不同的列指定不同的聚合方法
通过给agg方法传入一个字典，可以指定不同的列使用不同的聚合：

In [95]: grouped.agg({"C": "sum", "D": "std"})
Out[95]: 
            C         D
A                      
bar  0.392940  1.366330
foo -1.796421  0.884785
————————————————

。

```

### 去重计数
http://www.xieyp.xyz/index.php/uncategorized/215/


import pandas as pd cstm=pd.read_excel('customer_1.xls') fenzu=cstm.groupby(['所属部门','跟进人'],as_index=False) fz=fenzu.agg({'微信昵称'<u>:pd.Series.nunique</u>,'点击次数':'sum','授权电话':pd.Series.nunique}) #整体去重计数 cstm.跟进人.nunique()


### transform
- transform  (先agg  ，然后将group结果还原到原dataframe)
也相当于先agg，再储存到 to_dict()，最后map到dataframe



## map, apply, applymap
[知乎map 最清楚的教程](https://zhuanlan.zhihu.com/p/100064394)


map  dictrionary 
```pycon
In [21]: avg_salary_dict = data.groupby('company')['salary'].mean().to_dict()
​
In [22]: data['avg_salary'] = data['company'].map(avg_salary_dict)
```




### Series
- map: 不论是利用字典还是函数进行映射，`map`方法都是把对应的数据**逐个当作参数**传入到字典或函数中，得到映射后的值。
- <font color="#c00000"><font color="#ff0000">是不是可以把字典类比成一个函数？</font></font>
- 两种映射逻辑
	- 函数
	- 字典
```python
#①使用字典进行映射
data["gender"] = data["gender"].map({"男":1, "女":0})
​
#②使用函数
def gender_map(x):
    gender = 1 if x == "男" else 0
    return gender
#注意这里传入的是函数名，不带括号
data["gender"] = data["gender"].map(gender_map)
```

![[Pasted image 20230307131119.png|300]]

- apply 
`apply`方法的作用原理和`map`方法类似，区别在于`apply`能够传入功能更为复杂的函数。
map  只能接受一个参数，而apply 能接受多个参数


假设在数据统计的过程中，年龄`age`列有较大误差，需要对其进行调整（加上或减去一个值），由于这个加上或减去的值**未知**，故在定义函数时，需要加多一个参数`bias`，此时用`map`方法是操作不了的（传入`map`的函数只能接收一个参数），`apply`方法则可以解决这个问题。

```python
def apply_age(x,bias):
    return x+bias
​
#以元组的方式传入额外的参数
data["age"] = data["age"].apply(apply_age,args=(-3,))
```


### DataFrame


- apply

`axis=0`代表操作对`列columns`进行（遍历每一行），`axis=1`代表操作对`行row`进行（遍历每一列）
当沿着`轴0（axis=0）`进行操作时，会将各列(`columns`)默认以`Series`的形式作为参数，传入到你指定的操作函数中，操作后合并并返回相应的结果。


总结一下对`DataFrame`的`apply`操作：

1.  当`axis=0`时，对`每列columns`执行指定函数；当`axis=1`时，对`每行row`执行指定函数。
2.  无论`axis=0`还是`axis=1`，其传入指定函数的默认形式均为`Series`，可以通过设置`raw=True`传入`numpy数组`。
3.  对每个Series执行结果后，会将结果整合在一起返回（若想有返回值，定义函数时需要`return`相应的值）
4.  当然，`DataFrame`的`apply`和`Series`的`apply`一样，也能接收更复杂的函数，如传入参数等，实现原理是一样的，具体用法详见官方文档。


```text
# 沿着0轴求和
data[["height","weight","age"]].apply(np.sum, axis=0)
​
# 沿着0轴取对数
data[["height","weight","age"]].apply(np.log, axis=0)
```




- applymap


`applymap`的用法比较简单，会对`DataFrame`中的每个单元格执行指定函数的操作，虽然用途不如`apply`广泛，但在某些场合下还是比较有用的，如下面这个例子。

为了演示的方便，新生成一个`DataFrame`

```text
df = pd.DataFrame(
    {
        "A":np.random.randn(5),
        "B":np.random.randn(5),
        "C":np.random.randn(5),
        "D":np.random.randn(5),
        "E":np.random.randn(5),
    }
)
df
```


现在想将`DataFrame`中所有的值保留两位小数显示，使用`applymap`可以很快达到你想要的目的，代码和图解如下：

```pycon
df.applymap(lambda x:"%.2f" % x)
```



#### 相除div.
aa = df.iloc[:,1:].div(df1.iloc[:,1:],axis=0)

#### between

df.loc[df['Age'].between(left=0,right=20, inclusive='right')
-   参数left，分段/范围的下端点。
-   参数right，分段/范围的上端点。
-   参数inclusive，是否想要包括下端点和上端点，可以取下列值：both，neither，left或right。





# 其他
### 换行
1.反斜杠
对于一般表达式来说，反斜杠后直接回车即可实现续行，使用的关键在于反斜杠后不能用空格或者其他符号。


longlist = ['3D','3-D','3d','3-d','three-dimensions','Three-Dimensions','Three Dimensions','THREE DIMENSIONS','geometry',\
       'Geometry','GEOMETRY','Geometric','surface','Surfaces','Surface','SURFACE',\
       '3D Pose Estimation','Pose','POSE','POINTCLOUD']
print(longlist)

>>> ['3D', '3-D', '3d', '3-d', 'three-dimensions', 'Three-Dimensions', 'Three Dimensions', 'THREE DIMENSIONS', 'geometry', 'Geometry', 'GEOMETRY', 'Geometric', 'surface', 'Surfaces', 'Surface', 'SURFACE', '3D Pose Estimation', 'Pose', 'POSE', 'POINTCLOUD']

对于字符串也有同样的效果

longstring = 'this is a long long long long long long long \
string'
print(longstring)

>>> this is a long long long long long long long string

2.三引号
longstring1 = '''this is a long long long long long long long 
string'''
print(longstring1)
longstring2 = """this is another long long long long long long long 
string"""
print(longstring2)
1


this is a long long long long long long long string this is another long long long long long long long string
还可以实现ascii字符输出呢：

原文链接：https://blog.csdn.net/u014636245/article/details/87924595

### 去重
#### Seires

 Series去重操作

s.unique() 结果为一维数组

dic = {"A":1,"B":2,"C":3,"D":2}

s2 = pd.Series(dic)

s2.unique() # 原s2并未修改，该结果返回的是一维数组


#### DataFrame

**一、duplicated()**
duplicated()可以被用在DataFrame的三种情况下，分别是pandas.DataFrame.duplicated、pandas.Series.duplicated和pandas.Index.duplicated。他们的用法都类似，前两个会返回一个布尔值的Series，最后一个会返回一个布尔值的numpy.ndarray。

DataFrame.duplicated(subset=None, keep=‘first’)

subset：默认为None，需要标记重复的标签或标签序列
keep：默认为‘first’，如何标记重复标签

first：将除第一次出现以外的重复数据标记为True
last：将除最后一次出现以外的重复数据标记为True
False：将所有重复的项都标记为True（不管是不是第一次出现）
Series.duplicated(keep=‘first’)
keep：与DataFrame.duplicated的keep相同

Index.duplicated(keep=‘first’)
keep：与DataFrame.duplicated的keep相同


**二、drop_duplicates()**
与duplicated()类似，drop_duplicates()是直接把重复值给删掉。下面只会介绍一些含义不同的参数。

DataFrame.drop_duplicates(subset=None, keep=‘first’, inplace=False)
subset：与duplicated()中相同
keep：与duplicated()中相同
inplace：与pandas其他函数的inplace相同，选择是修改现有数据还是返回新的数据

Series.drop_duplicates()相比Series.duplicated()也是多了一个inplace参数，和上诉介绍一样，Index.drop_duplicates()与Index.duplicated()参数相同就不做赘述。下面是例子：

df = pd.DataFrame({
    'brand': ['Yum Yum', 'Yum Yum', 'Indomie', 'Indomie', 'Indomie'],
    'style': ['cup', 'cup', 'cup', 'pack', 'pack'],
    'rating': [4, 4, 3.5, 15, 5]
})

df.drop_duplicates()
————————————————

原文链接：https://blog.csdn.net/weixin_43887421/article/details/114926685

### 一键多值创建

([(31条消息) python在字典中创建一键多值的几种方法以及从其他数据结构转为一键多值的字典几种方法_字典一键多值_troublemaker、的博客-CSDN博客](https://blog.csdn.net/weixin_44912159/article/details/108457413))

#### 基本逻辑

```python
方法二：

先创建字典，再添加元素
dic = {}
dic['a'] = []
dic['a'].append(1)
dic['a'].append(2)
dic['a'].append(3)
print(dic)

# Out:{'a': [1, 2, 3]}

方法三：

导入collection库中的defaultdict方法，好处不需要先创建一个空列表
from collections import defaultdict
dic = defaultdict(list)
dic['a'].append(1)
dic['a'].append(2)
dic['a'].append(3)
print(dic)

# Out:defaultdict(<class 'list'>, {'a': [1, 2, 3]})

```

#### For loop实施
```python

for loop 转换
其他数据结构转为一键多值的字典几种方法
原始数据：

pairs = [('one', 1), ('two', 2), ('three', 3), ('four', 4), ('one', 11)]
转化成一键多值的字典形式：
 {'one': [1,11], 'two': [2], 'three': [3], 'four': [4]}

方法一：

一般都使用这个方法，其实看着有点杂乱，以后试着用方法二
pairs = [('one', 1), ('two', 2), ('three', 3), ('four', 4), ('one', 11)]
d = {}   
for key, value in pairs:
    if key not in d:
        d[key] = []
    d[key].append(value)
print(d)

# Out：{'one': [1, 11], 'two': [2], 'three': [3], 'four': [4]}


方法二：

这个就看着很舒服了
from collections import defaultdict

pairs = [('one', 1), ('two', 2), ('three', 3), ('four', 4), ('one', 11)]
d = defaultdict(list)
for key, value in pairs:
    d[key].append(value)  # 省去了if判断语句
print(d)

# Out:defaultdict(<class 'list'>, {'one': [1, 11], 'two': [2], 'three': [3], 'four'
————————————————

原文链接：https://blog.csdn.net/weixin_44912159/article/details/108457413

```
```
```


### 转置

dataFrame.T

> 愿我能**从容**地接受我不能改变的，
>          能**勇敢**地改变我所能改变的，
>          并有**智慧**能区分二者之间的不同 。 ——March


### 近期规划


--1\ 根据风险同事的两张表和 绑卡条件 bangka_flag=1用户量级，
use dmc_dev;
drop table if exists dmc_dev.wty_usefirstpaylater_230320_explore_user;
create table if NOT exists dmc_dev.wty_usefirstpaylater_230320_explore_user as
select pin  user_pin
        , risk_level 
        , acct_stat_code
        , bangka_flag
        , auth_flag
        , 'cunhu' typ 
from dmr_dev.hyr_xxhf_cunhu_stats
union 
select pin  user_pin
        , risk_level 
        , 999 acct_stat_code
        , 999 bangka_flag
        , auth_flag
        , 'xinhu' typ 
from dmr_dev.hyr_xxhf_xinhu_stats



----绑卡用户  --1,8924,9651  1.8亿应该没问题
select count(distinct user_pin  )  peo 
from    dmc_dev.wty_usefirstpaylater_230320_explore_user   
where  bangka_flag=1  


2、3.47亿和3.48亿的差值是由于 风险同事提供的两张表 老户和新户有pin重合，造成统计时重复统计（ 同一个用户可能既按照存户又按照新户统计一遍），所以人会多100万。
请问这边是想要把重复的人看成老户还是新户呢？因为总是要给用户安一个逻辑的.......
如果不在意的话，我就按照老户统计了~ 这样人数就是3.47亿 了

稍等，我今天晚上再刷一下数更新一下概况，不过，如果按照划分的人群的逻辑的话，差别预估应该不是很大
 select count(1) peo   --884054021
        , count(distinct  user_pin) peo -- 878012633
 from   dmc_dev.wty_usefirstpaylater_230320_explore_user




### 今日任务
- [ ] 任务1




---------

> Refreshing Day 

### 跟踪日志

#### 上午
- [ ] 09:00 工作
- [ ] 

#### 中午



#### 下午
- [x] 22:00 反思 note it




-------

### 杂记和反思


#### 新概念


#### 感悟


#### 改进


### 累计求和cumsum
https://blog.csdn.net/ilikede/article/details/78319542


```python

# 对Start Time进行排序，Connection Type分组，temp进行累计求和cumsum
wsw_1 = wsw.sort_values(['Start Time'])
wsw_1.loc[:, 'Connection Number'] = wsw_1.groupby(['Connection Type'])['temp'].cumsum()****

```
```
```



### 转换数据类型
[csdn](https://blog.csdn.net/jinruoyanxu/article/details/79150896)
act_chnl_mth['net_jy']=  act_chnl_mth['net_jy'].astype(float)   # 数据格式不符合



-
# skleran

### 一元线性回归


# 生成器
https://blog.csdn.net/HUSTHY/article/details/106882669



# 数据结构互相转换
 ## dict 转DataFame
 [dict 转DF的三种方法](https://blog.csdn.net/sinat_26811377/article/details/100065580)
**1、使用DataFrame函数时指定字典的索引index**
 **2、把字典dict转为list后传入DataFrame**
 **3、 使用DataFrame.from_dict函数**


```python 

import pandas as pd
 
my_dict = {'i': 1, 'love': 2, 'you': 3}
my_df = pd.DataFrame(my_dict,index=[0]).T
 
print(my_df)


```

```python
import pandas as pd
 
my_dict = {'i': 1, 'love': 2, 'you': 3}
my_list = [my_dict]
my_df = pd.DataFrame(my_list).T
 
print(my_df)
```


```python

import pandas as pd
 
my_dict = {'i': 1, 'love': 2, 'you': 3}
my_df = pd.DataFrame.from_dict(my_dict, orient='index')
 
print(my_df)
```
