
## 列表

列表都可以进行的操作包括索引，切片，加，乘，检查成员。
此外，Python 已经内置确定序列的长度以及确定最大和最小的元素的方法。
列表是最常用的 Python 数据类型，它可以作为一个方括号内的逗号分隔值出现。
<u>列表的数据项不需要具有相同的类型</u>


- 访问  索引[   ] 
- 更新列表   append() 方法   `list1.append('Baidu')`
- 删除 del   `del list[2]`
- 脚本操作符 ：  + 组合列表， * 重复   , for  迭代
![[Pasted image 20230312184112.png]]
- 截取：  `L[1:]`
- 嵌套列表
``` python
>>>a = ['a', 'b', 'c'] 
>>>>>> n = [1, 2, 3] 
 x = [a, n] 
 x [['a', 'b', 'c'], [1, 2, 3]] 
 x[0] ['a', 'b', 'c'] 
>>>>>> >>> >>> >>> >>> x[0][1] 'b'
```
- 列表比较  ： operator  模块的eq方法
```python
# 导入 operator 模块  
import operator  
  
a = [1, 2]  
b = [2, 3]  
c = [2, 3]  
print("operator.eq(a,b): ", operator.eq(a,b))  
print("operator.eq(c,b): ", operator.eq(c,b))
```





```python

函数

1

[len(list)](https://www.runoob.com/python3/python3-att-list-len.html)  
列表元素个数

2

[max(list)](https://www.runoob.com/python3/python3-att-list-max.html)  
返回列表元素最大值

3

[min(list)](https://www.runoob.com/python3/python3-att-list-min.html)  
返回列表元素最小值

4

[list(seq)](https://www.runoob.com/python3/python3-att-list-list.html)  
将元组转换为列表

Python包含以下方法:

1

[list.append(obj)](https://www.runoob.com/python3/python3-att-list-append.html)  
在列表末尾添加新的对象

2

[list.count(obj)](https://www.runoob.com/python3/python3-att-list-count.html)  
统计某个元素在列表中出现的次数

3

[list.extend(seq)](https://www.runoob.com/python3/python3-att-list-extend.html)  
在列表末尾一次性追加另一个序列中的多个值（用新列表扩展原来的列表）

4

[list.index(obj)](https://www.runoob.com/python3/python3-att-list-index.html)  
从列表中找出某个值第一个匹配项的索引位置

5

[list.insert(index, obj)](https://www.runoob.com/python3/python3-att-list-insert.html)  
将对象插入列表

6

[list.pop([index=-1])](https://www.runoob.com/python3/python3-att-list-pop.html)  
移除列表中的一个元素（默认最后一个元素），并且返回该元素的值

7

[list.remove(obj)](https://www.runoob.com/python3/python3-att-list-remove.html)  
移除列表中某个值的第一个匹配项

8

[list.reverse()](https://www.runoob.com/python3/python3-att-list-reverse.html)  
反向列表中元素

9

[list.sort( key=None, reverse=False)](https://www.runoob.com/python3/python3-att-list-sort.html)  
对原列表进行排序

10

[list.clear()](https://www.runoob.com/python3/python3-att-list-clear.html)  
清空列表

11

[list.copy()](https://www.runoob.com/python3/python3-att-list-copy.html)  
复制列表
```





## 元组
Python 的元组与列表类似，不同之处在于元组的元素不能修改。
元组使用小括号 ( )，列表使用方括号 [ ]。
元组创建很简单，只需要在括号中添加元素，并使用逗号隔开即可。
创建空元组  `tup1 = ()`
修改元组：元组中的元素值是不允许修改的，但我们可以对元组进行连接组合，本质是创建新元组
```python
tup1 = (12, 34.56) 
tup2 = ('abc', 'xyz') 
# 以下修改元组元素操作是非法的。 
# tup1[0] = 100 # 创建一个新的元组 
tup3 = tup1 + tup2 
print (tup3)
```
删除：元组中的元素值是不允许删除的，但我们可以使用del语句来删除整个元组， `del tup`
元组中只包含一个元素时，需要在元素后面添加逗号 , ，否则括号会被当作运算符使用：
与字符串一样，元组之间可以使用 +、+=和 * 号进行运算。这就意味着他们可以组合和复制，运算后会生成一个新的元组。

截取操作：和列表同质

```python
序号
1

len(tuple)  
计算元组元素个数。

>>> tuple1 = ('Google', 'Runoob', 'Taobao')
>>> len(tuple1)
3
>>> 

2

max(tuple)  
返回元组中元素最大值。

>>> tuple2 = ('5', '4', '8')
>>> max(tuple2)
'8'
>>> 

3

min(tuple)  
返回元组中元素最小值。

>>> tuple2 = ('5', '4', '8')
>>> min(tuple2)
'4'
>>> 

4

tuple(iterable)  
将可迭代系列转换为元组。

>>> list1= ['Google', 'Taobao', 'Runoob', 'Baidu']
>>> tuple1=tuple(list1)
>>> tuple1
('Google', 'Taobao', 'Runoob', 'Baidu')
```


## 字典
字典是另一种可变容器模型，且可存储任意类型对象。
字典的每个键值 key=>value 对用冒号 : 分割，每个对之间用逗号(**,**)分割，整个字典包括在花括号 {} 中 ,格式如下所示：
键必须是唯一的，但值则不必。
值可以取任何数据类型，但键必须是不可变的，如字符串，数字。

创建：使用内建函数 dict() 创建字典：`emptyDict = dict()  emptyDict = dict()   `

访问： `dict[key]    例：tinydict['Name']`

删除字典：  删除一个元素、清空内容、删除字典实体本身
``` python
del tinydict['Name'] # 删除键 'Name' 
tinydict.clear() # 清空字典 
del tinydict # 删除字典
```


字典键的特性：
1）不允许同一个键出现两次。创建时如果同一个键被赋值两次，后一个值会被记住，如下实例：
2）键必须不可变，所以可以用数字，字符串或元组充当，而用列表就不行，如下实例


```python
序号

函数及描述

1

[dict.clear()](https://www.runoob.com/python3/python3-att-dictionary-clear.html)  
删除字典内所有元素 

2

[dict.copy()](https://www.runoob.com/python3/python3-att-dictionary-copy.html)  
返回一个字典的浅复制

3

[dict.fromkeys()](https://www.runoob.com/python3/python3-att-dictionary-fromkeys.html)  
创建一个新字典，以序列seq中元素做字典的键，val为字典所有键对应的初始值

4

[dict.get(key, default=None)](https://www.runoob.com/python3/python3-att-dictionary-get.html)  
返回指定键的值，如果键不在字典中返回 default 设置的默认值

5

[key in dict](https://www.runoob.com/python3/python3-att-dictionary-in.html)  
如果键在字典dict里返回true，否则返回false

6

[dict.items()](https://www.runoob.com/python3/python3-att-dictionary-items.html)  
以列表返回一个视图对象

7

[dict.keys()](https://www.runoob.com/python3/python3-att-dictionary-keys.html)  
返回一个视图对象

8

[dict.setdefault(key, default=None)](https://www.runoob.com/python3/python3-att-dictionary-setdefault.html)  
和get()类似, 但如果键不存在于字典中，将会添加键并将值设为default

9

[dict.update(dict2)](https://www.runoob.com/python3/python3-att-dictionary-update.html)  
把字典dict2的键/值对更新到dict里

10

[dict.values()](https://www.runoob.com/python3/python3-att-dictionary-values.html)  
返回一个视图对象

11

[pop(key[,default])](https://www.runoob.com/python3/python3-att-dictionary-pop.html)  
删除字典 key（键）所对应的值，返回被删除的值。

12

[popitem()](https://www.runoob.com/python3/python3-att-dictionary-popitem.html)  
返回并删除字典中的最后一对键和值。
```




## 集合
集合（set）是一个无序的不重复元素序列。

可以使用大括号 { } 或者 set() 函数创建集合，注意：创建一个空集合必须用 set() 而不是 { }，因为 { } 是用来创建一个空字典。
```python
方法

判断元素是否在集合中：  x in s


描述

[add()](https://www.runoob.com/python3/ref-set-add.html)

为集合添加元素

[clear()](https://www.runoob.com/python3/ref-set-clear.html)

移除集合中的所有元素

[copy()](https://www.runoob.com/python3/ref-set-copy.html)

拷贝一个集合

[difference()](https://www.runoob.com/python3/ref-set-difference.html)

返回多个集合的差集

[difference_update()](https://www.runoob.com/python3/ref-set-difference_update.html)

移除集合中的元素，该元素在指定的集合也存在。

[discard()](https://www.runoob.com/python3/ref-set-discard.html)

删除集合中指定的元素

[intersection()](https://www.runoob.com/python3/ref-set-intersection.html)

返回集合的交集

[intersection_update()](https://www.runoob.com/python3/ref-set-intersection_update.html)

返回集合的交集。

[isdisjoint()](https://www.runoob.com/python3/ref-set-isdisjoint.html)

判断两个集合是否包含相同的元素，如果没有返回 True，否则返回 False。

[issubset()](https://www.runoob.com/python3/ref-set-issubset.html)

判断指定集合是否为该方法参数集合的子集。

[issuperset()](https://www.runoob.com/python3/ref-set-issuperset.html)

判断该方法的参数集合是否为指定集合的子集

[pop()](https://www.runoob.com/python3/ref-set-pop.html)

随机移除元素

[remove()](https://www.runoob.com/python3/ref-set-remove.html)

移除指定元素

[symmetric_difference()](https://www.runoob.com/python3/ref-set-symmetric_difference.html)

返回两个集合中不重复的元素集合。

[symmetric_difference_update()](https://www.runoob.com/python3/ref-set-symmetric_difference_update.html)

移除当前集合中在另外一个指定集合相同的元素，并将另外一个指定集合中不同的元素插入到当前集合中。 

[union()](https://www.runoob.com/python3/ref-set-union.html)

返回两个集合的并集

[update()](https://www.runoob.com/python3/ref-set-update.html)

给集合添加元素
```




## 条件控制

### if  elif  else  while
```python
if condition_1: statement_block_1 
elif condition_2: statement_block_2 
else: statement_block_3
```

-   如果 "condition_1" 为 True 将执行 "statement_block_1" 块语句
-   如果 "condition_1" 为False，将判断 "condition_2"
-   如果"condition_2" 为 True 将执行 "statement_block_2" 块语句
-   如果 "condition_2" 为False，将执行"statement_block_3"块语句

Python 中用 **elif** 代替了 **else if**，所以if语句的关键字为：**if – elif – else**。

**注意：**

-   1、每个条件后面要使用冒号 :，表示接下来是满足条件后要执行的语句块。
-   2、使用缩进来划分语句块，相同缩进数的语句在一起组成一个语句块。
-   3、在 Python 中没有 switch...case 语句，但在 Python3.10 版本添加了 match...case，功能也类似，详见下文。

```python
number = 7 
guess = -1 
print("数字猜谜游戏!") 
while guess != number: 
	guess = int(input("请输入你猜的数字：")) 
	if guess == number: 
		print("恭喜，你猜对了！") 
	elif guess < number: 
		print("猜的数字小了...") 
	elif guess > number: 
		print("猜的数字大了...")
```


### if嵌套

```PYTHON
if 表达式1:
    语句
    if 表达式2:
        语句
    elif 表达式3:
        语句
    else:
        语句
elif 表达式4:
    语句
else:
    语句


num=int(input("输入一个数字：")) 
if num%2==0: 
	if num%3==0: 
		print ("你输入的数字可以整除 2 和 3") 
	else: print ("你输入的数字可以整除 2，但不能整除 3") 
else: 
	if num%3==0: 
		print ("你输入的数字可以整除 3，但不能整除 2") 
	else: 
		print ("你输入的数字不能整除 2 和 3")
```


### match  ....case
Python 3.10 增加了 match...case 的条件判断，不需要再使用一连串的 if-else 来判断了。
match 后的对象会依次与 case 后的内容进行匹配，如果匹配成功，则执行匹配到的表达式，否则直接跳过，_ 可以匹配一切。
case _: 类似于 C 和 Java 中的 default:，当其他 case 都无法匹配时，匹配这条，保证永远会匹配成功。

```PYTHON 
match subject:
    case <pattern_1>:
        <action_1>
    case <pattern_2>:
        <action_2>
    case <pattern_3>:
        <action_3>
    case _:
        <action_wildcard>



mystatus=400  
print(http_error(400))  
  
def http_error(status):  
    match status:  
        case 400:  
            return "Bad request"  
        case 404:  
            return "Not found"  
        case 418:  
            return "I'm a teapot"  
        case _:  
            return "Something's wrong with the internet"
```




## 循环语句

for  & while
![[Pasted image 20230312193104.png|300]]




### while 循环

语法
while 判断条件(condition)：
    执行语句(statements)……
    
![[Pasted image 20230312193218.png|300]]




#### 有限和无限循环


有限循环  --正常的while 判断条件
```python
n = 100 
sum = 0 
counter = 1 
while counter <= n: 
	sum = sum + counter 
	counter += 1 
print("1 到 %d 之和为: %d" % (n,sum))
```

无限循环  --可以使用 **CTRL+C** 来退出当前的无限循环
```python
var = 1 
while var == 1 : # 表达式永远为 true
	num = int(input("输入一个数字 :")) 
	print ("你输入的数字是: ", num) print ("Good bye!") 
	
```



### while 循环使用else语句
如果 while 后面的条件语句为 false 时，则执行 else 的语句块。

语法格式如下：
```  PYTHON

while  <expr>:
	<statement(s)>
else:
	<additional_statement(s)>



count = 0 
while count < 5: 
	print (count, " 小于 5") 
	count = count + 1 
else: 
	print (count, " 大于或等于 5")

```



### for 语句

可以配合列表 ，str， range（）  使用

```PYTHON
for number in range(1, 6): 
	print(number)
```


### for   else   break 

在 Python 中，for...else 语句用于在循环结束后执行一段代码。
```PYTHON 
for item in iterable:
    # 循环主体
else:
    # 循环结束后执行的代码
```

当循环执行完毕（即遍历完 iterable 中的所有元素）后，会执行 else 子句中的代码，如果在循环过程中遇到了 break 语句，则会中断循环，此时不会执行 else 子句。


```python

sites = ["Baidu", "Google","Runoob","Taobao"] 
for site in sites: 
	if site == "Runoob": 
		print("菜鸟教程!") 
		break      # 跳出循环体
	print("循环数据 " + site) 
else: print("没有循环数据!") 
print("完成循环!")


循环数据 Baidu
循环数据 Google
菜鸟教程!
完成循环!
```


### range()函数
如果你需要遍历数字序列，可以使用内置 range() 函数。它会生成数列，可以指定步长，可以和 len 结合；
```PYTHON
a = ['Google', 'Baidu', 'Runoob', 'Taobao', 'QQ'] 
for i in range(len(a)): 
	print(i, a[i]) 
	
	... 0 Google 1 Baidu 2 Runoob 3 Taobao
```



### break    continue  函数
**break** 语句可以跳出 for 和 while 的循环体。如果你从 for 或 while 循环中终止，任何对应的循环 else 块将不执行。
**continue** 语句被用来告诉 Python 跳过当前循环块中的剩余语句，然后继续进行下一轮循环。

![[Pasted image 20230312201716.png|200]]

![[Pasted image 20230312201825.png|300]]


### pass语句
pass 不做任何事情，一般用做占位语句，如下实例
``` PYTHON

while True: 
	pass # 等待键盘中断 (Ctrl+C)


for letter in 'Runoob': 
	if letter == 'o': 
		pass 
		print ('执行 pass 块') 
	print ('当前字母 :', letter) 
	
	
print ("Good bye!")


```



None 为 False



## 函数

### map（）

**map()** 会根据提供的函数对指定序列做映射。

第一个参数 function 以参数序列中的每一个元素调用 function 函数，返回包含每次 function 函数返回值的新列表

map() 函数语法： map(function, iterable, ...)

```python
>>> def square(x) :         # 计算平方数  
...     return x ** 2  
...   
>>> map(square, [1,2,3,4,5])    # 计算列表各个元素的平方  
<map object at 0x100d3d550>     # 返回迭代器  
>>> list(map(square, [1,2,3,4,5]))   # 使用 list() 转换为列表  
[1, 4, 9, 16, 25]  
>>> list(map(lambda x: x ** 2, [1, 2, 3, 4, 5]))   # 使用 lambda 匿名函数  
[1, 4, 9, 16, 25]  
>>>
```


而`map()`可以让我们使用一种简单且优雅得多的方式实现。  
**示例**

```python
x_s = [1, 2, 3]
y_s = [3, 2, 1]

# 对序列x_s和y_s中的对应元素进行相加
a = map(lambda x, y:x+y, x_s, y_s)
```

[![](https://upload-images.jianshu.io/upload_images/2816752-b999b90d935ac9c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)](https://upload-images.jianshu.io/upload_images/2816752-b999b90d935ac9c7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

`map()`函数生成的结果序列不会把全部结果显示出来，要想获得结果序列，可以使用list()方法。  
[](https://upload-images.jianshu.io/upload_images/2816752-bd24c8152abe6a01.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

### Lamba

python 使用 lambda 来创建匿名函数。

-   lambda只是一个表达式，函数体比def简单很多。
-   lambda的主体是一个表达式，而不是一个代码块。仅仅能在lambda表达式中封装有限的逻辑进去。
-   lambda函数拥有自己的命名空间，且不能访问自有参数列表之外或全局命名空间里的参数。
-   虽然lambda函数看起来只能写一行，却不等同于C或C++的内联函数，后者的目的是调用小函数时不占用栈内存从而增加运行效率。

### 语法

lambda函数的语法只包含一个语句，如下：

lambda [arg1 [,arg2,.....argn]]:expression




### apply

[csdn](https://blog.csdn.net/qq_44718932/article/details/120823745)

**概括：**  
**apply：用在dataframe上，用于对row或者column进行计算**  
**applymap ：用于dataframe上，是元素级别的操作**  
**map（python自带）：用于series上，是元素级别的操作**

可以通俗的理解apply和map都为数据集迭代加工的方法  
apply用在dataframe上，而map用于常规一维数据处理  
使用map也可以处理dataframe数据只是会显得很冗余

#### apply
```python
from pandas import DataFrame
import numpy as np

df = DataFrame(data=np.random.randint(0, 10, size=(4, 4)), columns=['a', 'b', 'c', 'd'])
print(df)
# out:
   a  b  c  d
0  6  4  9  5
1  9  1  9  9
2  4  5  2  8
3  0  3  8  7


# 作用在一列上  axis=0表示作用于列  不填默认为0
r1 = df.apply(lambda x: x.max() - x.min(), axis=0)
print(r1)
# out:
a    9
b    4
c    7
d    4
dtype: int64

r2 = df.apply(lambda x: x.max() - x.min())
print(r2)
# out:
a    9
b    4
c    7
d    4
dtype: int64

# 作用在一行上
r3 = df.apply(lambda x: x.max() - x.min(), axis=1)
print(r3)
# out:
0    5
1    8
2    6
3    8
dtype: int64

```


#### applymap
```python
r4 = df.applymap(lambda x: str(x)+'s')
print(r4)
# out:
    a   b   c   d
0  6s  4s  9s  5s
1  9s  1s  9s  9s
2  4s  5s  2s  8s
3  0s  3s  8s  7s

```





#### apply  和  map对比
可以通俗的理解apply和map都为数据集迭代加工的方法  
apply用在dataframe上，而map用于常规一维数据处理  
使用map也可以处理dataframe数据只是会显得很冗余


总结：先看看是对dataframe还是series进行操作，如果是dataframe则选择用apply,格式是dataframe.apply(lambda x:f(x),axis=1) #f(x)可以是def自定义的函数也可以直接式函数，axis=1是行循环，表示此时的X是代表dataframe的一行。如果是series可以选择apply也可以选择map，格式都是series.appply(lambda x:f(x))或者series.map(lambda x:f(x)).
————————————————
版权声明：本文为CSDN博主「xiaoshu_yilian」的原创文章，遵循CC 4.0 BY-SA版权协议，转载请附上原文出处链接及本声明。
原文链接：https://blog.csdn.net/weixin_38003620/article/details/105880483

```python
import pandas as pd

filepath = "movie.csv"
data = pd.read_csv(filepath, names=["author", "comment", "date"], usecols=[0, 1, 2])
# 使用apply处理
data['date'] = data['date'].apply(lambda x: str(x).split(' ')[0])
print(data['date'])
# 使用map处理
data['date'] = list(map(lambda x: str(x).split(' ')[0], list(data['date'])))
print(data['date'])

```




### 信息格式化储存

https://blog.csdn.net/qq_41578262/article/details/124627943



8.字典生成式

它类似于列表生成式。字典生成式是一种基于iterables的字典创建方法。

{x: x**2 for x in range(5)}

{0: 0, 1: 1, 2: 4, 3: 9, 4: 16}

{word: len(word) for word in ['data','science','is','awesome']}

{'awesome': 7, 'data': 4, 'is': 2, 'science': 7}

iterable中的元素成为字典的键。这些值是根据字典生成式中的赋值确定的。

9.从列表创建字典

我们可以使用列表或元组列表创建字典。

a = [['A',4], ['B',5], ['C',11]]

dict(a)

{'A': 4, 'B': 5, 'C': 11}

b = [('A',4), ('B',5), ('C',11)]