### 教程链接
菜鸟教程：
https://www.runoob.com/python3/python3-data-type.html

印象笔记




### 基础语法：
- ```;``` 支持一行输入多条语句
- 单引号和双引号一样
-  \# 和  三引号（单双）都是注释
-   反斜杠 --转义字符   单独的一个反斜杠"\"在编程中通常用于[转义字符](https://so.csdn.net/so/search?q=%E8%BD%AC%E4%B9%89%E5%AD%97%E7%AC%A6&spm=1001.2101.3001.7020)，如\0表示“空字符”\r表示“回车”，\n表示“换行”等；所有通常要用到反斜杠时，要**用两个反斜杠"\\"来表示一个反斜杠“\”的含义**。
	-   多行输入，注意不能用在各种括号里面
- input()  输入
- 注意大小写敏感，不像sql

### 数据类型：
数字：int, float，complex
字符串
列表
元组
字典：keys， values
集合：集合是一个无序不重复元素的集。
-   **不可变数据（3 个）：**Number（数字）、String（字符串）、Tuple（元组）；
-   **可变数据（3 个）：**List（列表）、Dictionary（字典）、Set（集合）


type
isinstance


### 数据类型转换
#### 隐式
数字类型的如int 可以通过和小数相加变成小数
而string 类型的则不能通过这种方式



#### 显式
函数|描述
--|--
[int(x [,base])](https://www.runoob.com/python3/python-func-int.html)| 将x转换为一个整数
[float(x)](https://www.runoob.com/python3/python-func-float.html)|将x转换到一个浮点数
[complex(real [,imag])](https://www.runoob.com/python3/python-func-complex.html)|创建一个复数
[str(x)](https://www.runoob.com/python3/python-func-str.html)|将对象 x 转换为字符串
[repr(x)](https://www.runoob.com/python3/python-func-repr.html)|将对象 x 转换为表达式字符串
[eval(str)](https://www.runoob.com/python3/python-func-eval.html)|用来计算在字符串中的有效Python表达式,并返回一个对象
[tuple(s)](https://www.runoob.com/python3/python3-func-tuple.html)|将序列 s 转换为一个元组
[list(s)](https://www.runoob.com/python3/python3-att-list-list.html)|将序列 s 转换为一个列表
[set(s)](https://www.runoob.com/python3/python-func-set.html)|转换为可变集合
[dict(d)](https://www.runoob.com/python3/python-func-dict.html)|创建一个字典。d 必须是一个 (key, value)元组序列。
[frozenset(s)](https://www.runoob.com/python3/python-func-frozenset.html)|转换为不可变集合
[chr(x)](https://www.runoob.com/python3/python-func-chr.html)|将一个整数转换为一个字符
[ord(x)](https://www.runoob.com/python3/python-func-ord.html)|将一个字符转换为它的整数值
[hex(x)](https://www.runoob.com/python3/python-func-hex.html)|将一个整数转换为一个十六进制字符串
[oct(x)](https://www.runoob.com/python3/python-func-oct.html)  |将一个整数转换为一个八进制字符串



### 推导式&数据结构：

#### 推导式
可以从一个数据序列构建另一个新的数据序列的结构体。
Python 支持各种数据结构的推导式：

-   列表(list)推导式  [ ] 
-   字典(dict)推导式  { }
-   集合(set)推导式    {key: }
-   元组(tuple)推导式  { }

##### 列表推导式
``` python
[表达式 for 变量 in 列表] [out_exp_res for out_exp in input_list] 
或者
[表达式 for 变量 in 列表 if 条件] [out_exp_res for out_exp in input_list if condition]

```

-   out_exp_res：列表生成元素表达式，可以是有返回值的函数。 注意表达式是针对out_exp 起作用而不是 input_list
-   for out_exp in input_list：迭代 input_list 将 out_exp 传入到 out_exp_res 表达式中。
-   if condition：条件语句，可以过滤列表中不符合条件的值。
例：
``` python
a=['I','AM','A','PUSSY']
# b=[a.upper() for i in a ]    # AttributeError: 'list' object has no attribute 'upper'
b=[i.lower() for i in a ] 
c= [i.lower() for i in a if len(i)>=2 ]  #加上条件
print(b)
print(c)
```

##### 字典推导式
``` python
{ key_expr: value_expr for value in collection } 
或 { key_expr: value_expr for value in collection if condition }
```


##### 集合推导式
``` python
{ expression for item in Sequence } 
或 { expression for item in Sequence if conditional }
```

##### 元组推导式

元组推导式和列表推导式的用法也完全相同，只是元组推导式是用 () 圆括号将各部分括起来，而列表推导式用的是中括号 []，另外元组推导式返回的结果是一个生成器对象。
==使用 tuple() 函数，可以直接将生成器对象转换成元组==
``` python
(expression for item in Sequence ) 
或 (expression for item in Sequence if conditional )

a = (x for x in range(1,10))
a
tuple(a)  # 使用 tuple() 函数，可以直接将生成器对象转换成元组

```



#### 迭代器与生成器
[参考链接](https://www.runoob.com/python3/python3-iterator-generator.html)

##### 迭代器：容器
迭代器是一个可以记住遍历的位置的对象。

迭代器对象从集合的第一个元素开始访问，直到所有的元素被访问完结束。迭代器只能往前不会后退。

迭代器有两个基本的方法：**iter()** 和 **next()**。

字符串，列表或元组对象都可用于创建迭代器：


##### 生成器：函数
在 Python 中，使用了 yield 的函数被称为生成器（generator）。

跟普通函数不同的是，生成器是一个返回迭代器的函数，只能用于迭代操作，更简单点理解生成器就是一个迭代器。 

在调用生成器运行的过程中，每次遇到 yield 时函数会暂停并保存当前所有的运行信息，返回 yield 的值, 并在下一次执行 next() 方法时从当前位置继续运行。

调用一个生成器函数，返回的是一个迭代器对象


#### 数据结构
##### 列表的修改方法
Python中列表是可变的，这是它区别于字符串和元组的最重要的特点，一句话概括即：列表可以修改，而字符串和元组不能

方法|描述
--|--
list.append(x)|把一个元素添加到列表的结尾，相当于 a[len(a):] = [x]。
list.extend(L)|通过添加指定列表的所有元素来扩充列表，相当于 a[len(a):] = L。 
list.insert(i, x)|在指定位置插入一个元素。第一个参数是准备插入到其前面的那个元素的索引，例如 a.insert(0, x) 会插入到整个列表之前，而 a.insert(len(a), x) 相当于 a.append(x) 。
list.remove(x)|删除列表中值为 x 的第一个元素。如果没有这样的元素，就会返回一个错误。
list.pop([i])|从列表的指定位置移除元素，并将其返回。如果没有指定索引，a.pop()返回最后一个元素。元素随即从列表中被移除。（方法中 i 两边的方括号表示这个参数是可选的，而不是要求你输入一对方括号，你会经常在 Python 库参考手册中遇到这样的标记。）
list.clear()|移除列表中的所有项，等于del a[:]。
list.index(x)|返回列表中第一个值为 x 的元素的索引。如果没有匹配的元素就会返回一个错误。
list.count(x)|返回 x 在列表中出现的次数。
list.sort()|对列表中的元素进行排序。
list.reverse()|倒排列表中的元素。
list.copy()|返回列表的浅复制，等于a[:]。

##### 列表堆栈和队列
堆栈 append， pop


队列
也可以把列表当做队列用，只是在队列里第一加入的元素，第一个取出来；但是拿列表用作这样的目的效率不高。在列表的最后添加或者弹出元素速度快，然而在列表里插入或者从头部弹出速度却不快（因为所有其他的元素都得一个一个地移动）。
```python
>>> from collections import deque  
>>> queue = deque(["Eric", "John", "Michael"])  
>>> queue.append("Terry") # Terry arrives  
>>> queue.append("Graham") # Graham arrives  
>>> queue.popleft() # The first to arrive now leaves  
'Eric'  
>>> queue.popleft() # The second to arrive now leaves  
'John'  
>>> queue # Remaining queue in order of arrival  
deque(['Michael', 'Terry', 'Graham'])

```

##### 字典

##### 集合


##### del:万物皆可删
对列表、对字典 都可操作，
可以删除内部的某个内容，也都可以删除

### 条件&循环语句

### 函数


# Numpy & Pandas：
## Numpy
[菜鸟教程链接](https://www.runoob.com/numpy/numpy-tutorial.html)


注意array 的计算是permanent的
### array 数组
#### 构建
1 、list to/tuple array
format: ([])  
记住，两层括号里面的空间才是被自由操控的，无论是【】还是（），其都需要保持一个数组的概念


2、 A nest of arrays:
matrix

#### 属性
np.shape
np.arange()
np.linsapce() : including the start & end; same stepsize; stepsize is determined by the number requied(the 3rd parameter)
np.eye()  identity matrix

#### Zeros and Ones
np.zeros((5,5))
np.ones(3)  如果只有一个参数，默认是一个shape为（0，n)的aarray --其实只是一个vector shape形式只有一个参数（25，）

#### Linespace& arange()
np.linspace(0,5,20)Note that `.linspace()` _includes_ the stop value. To obtain an array of common fractions, increase the number of items:


np.arange(0,11,2)  #Return evenly spaced values within a given interval.
不一定 includes_ the stop value
Return evenly spaced values within a given interval. [[reference](https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.arange.html)]

#### Random

np.random.randint(1,100) 
np.random.randint(1,100,10)  --默认
Returns random integers from `low` (inclusive) to `high` (exclusive). [[reference](https://docs.scipy.org/doc/numpy-1.15.0/reference/generated/numpy.random.randint.html)]


np.random.seed(42)
np.random.rand(4)
-- seed 和对应的 rand 需要在同一个板块 随机数才会固定


np.random.randn(2)
np.random.randn(5,5)

##### 间隔
arr=np.arange(10,51)
arr[0::2]

从index0 开始，间隔为2

#### array[:] Vs array.copy()
`=` 对array操作是直接赋值的意思，会对array的数值进行改变（并不创造新的对象，而是把一个新的变量名称和原来的实体连接起来），所以对新变量的操作也会影响到老实体；

`array.copy()` 创造一个新的实体对应一个新的变量，对新变量的操作不影响老实体；

``o get a copy need to be explicit
  arr_copy = arr.copy()
  arr_copy
	arr_copy= arr_copy*2
	arr_copy[1:`4]=0
	arr_copy ``


#### Broadcasting
NumPy arrays differ from normal Python lists because of their ability to broadcast. With lists, you can only reassign parts of a list with new parts of the same size and shape. That is, if you wanted to replace the first 5 elements in a list with a new value, you would have to pass in a new 5 element list. With NumPy arrays, you can broadcast a single value across a larger set of values:

Setting a value with index range (Broadcasting)
arr[0:5]=100
arr  array([100, 100, 100, 100, 100,   5,   6,   7,   8,   9,  10])

#### Conditional selection
即用一个条件判断来slice array（所以标志是判断符号），本质是用条件判断后得到true FALSE的结果来slice

bool_arr = arr>4
arr[bool_arr]

### Arithmetic Operations
*注意numpy 在遇到1/0 的情况时 不会报错，只会提示*

#### math methods
np.sqrt(arr)
np.sxp(arr)
np.sin(arr)
np.log(arr)


#### summary statistics

arr.sum()
arr.mean()
arr.max()

##### axis
When working with 2-dimensional arrays (matrices) we have to consider rows and columns. This becomes very important when we get to the section on pandas. In array terms, axis 0 (zero) is the vertical axis (rows), and axis 1 is the horizonal axis (columns). These values (0,1) correspond to the order in which arr.shape values are returned.

arr_2d.mean(axis=1)
arr_2d.sum(axis=0)





##### Broadcast
是numpy 独特的特点，其虽然和 python内置的list长得像，但是list只是一个object，不能直接用数学公式对它进行准确的计算



## Pandas

-   Introduction to Pandas
-   Series
-   DataFrames
-   Missing Data
-   GroupBy
-   Merging, Joining and Concatenating
-   Operations
-   Data Input and Output

series相对于np 最明显的不同是  有明确的index
里面两个最基础的元素 data， index
### Series
#### 创建
list,array, dictionary 都可以用来创建

labels = ['a','b','c']
my_list = [10,20,30]
arr = np.array([10,20,30])
d = {'a':10,'b':20,'c':30}

list;
pd.Series(data=my_list,index=labels)
pd.Series(my_list,labels)

array:
pd.Series(arr)

dictionaryz;
pd.Series(d)
pd.Series(list(d.keys()),list(d.values()))


### DataFrames
We can think of a DataFrame as a bunch of Series objects put together to share the same index.

Each individual column is a series

相对于series 多了一个column参数
df = pd.DataFrame(randn(5,4),index='A B C D E'.split(),columns='W X Y Z'.split())
对dataframe的修改不会影响其原来的值，除非 set `inplace=True`


#### slicing -2 brackets [[]]

切一列 ：
df['W']  结果是一个series

切多列：
Pass a list of column names
df[['W','Z']]

==**注意这种切（无loc，iloc） 只能切列，不能切行，不能切行列组成的块 **== 

创建 new column
df['new'] = df['W'] + df['Y']

删除列
df.drop('new',axis=1)  注意axis的默认参数为0
df.drop('new',axis=1,inplace=True)  表示实际对df 进行修改




#### loc,iloc
二者默认的第一个参数都是行index，所以在用loc slice的 不能只用一个参数来select列参数（它会以为是行index）

loc 是按照dataframe目前的index select

iloc 是按照dataframe默认的 number index select；里面必须都要是数字 

df.iloc[2]、df.loc['A'] select 行
df.loc['A','W']
df.iloc[2,3] --#df.iloc[2,'W'] wrong




####  Selecting subset of rows and columns


df.loc[['A','B'],['W','Y']]
df.loc[['A','B']][['W','Y']]
--wrong:df[['A','B']][['W','Y']]


#### Conditional selection

对所有行对应的的列值 进行判断，根据判断结果的true还是false 保留值
##### 整个dataframe
df[df>0]  行列不会删减

##### 对于某一个列
df[df['W']>0]

##### 多个列的条件

**两个条件：df[(df['W']>0) & (df['Y'] > 1)]**
且`& ` ， 或`|`


#### set_index & reset_index
reset_index()：
Reset to default 0,1...n index
df.reset_index()
原来的index 默认变成列，列名默认为index；


set_index():
df.set_index('States',inplace=True)
'States'  为原来的列名

#### df summaries                                              There are a couple of ways to obtain summary data on      DataFrames.  
**df.describe()** provides summary statistics on all numerical columns.  
**df.info and df.dtypes** displays the data type of all columns.      



#### 处理缺失值

.dropna
.fillna 
 - axis
 - thresh
 - fillna
 - value 


### Groupby
df.groupby('Person').count()
.mean()
.std()
.max(), .min()
by_comp.describe().transpose()
by_comp.describe().transpose()['MSFT']
by_comp.describe().transpose()[['MSFT','GOOG']]



### Operations
#### Info on Unique Values
df['col1'].unique()  # 取出独特值
df['col2'].nunique()  # 独特值的具体个数
df['col2'].value_counts()  # 只对于series起作用

#### selecting data
#Select from DataFrame using criteria from multiple columns
``newdf = df[(df['col1']>2) & (df['col2']==444)] ``

#### Sorting and Ordering
df.sort_values(by='col2') # inplace=False by default

#### applying function
def times2(x):
    return x*2
	
df['col1'].apply(times2)
df['col3'].apply(len)  **为什么count不行？**


#### Others
delete a column: `del df['col1'] `

get column and index names: `df.columns`  &   `df.index`




### Input & Output
#### CSV
df = pd.read_csv('example.csv')
df.to_csv('example.csv',index=False)


#### Excel
pd.read_excel('Excel_Sample.xlsx',sheet_name='Sheet1')
df.to_excel('Excel_Sample.xlsx',sheet_name='Sheet1')

Pandas can read and write MS Excel files. However, this only imports data, not formulas or images. A file that contains images or macros may cause the .read_excel()method to crash.



#### HTML
df = pd.read_html('http://www.fdic.gov/bank/individual/failed/banklist.html')

### 逻辑：

#### 属性& 函数

行缩进表示代码块
条件
循环
迭代器& 生成器


### Module:
#### Datetime(时间序列用)
