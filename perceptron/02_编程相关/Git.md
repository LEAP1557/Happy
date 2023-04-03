
![[Pasted image 20230304145715.png|300]]



### 其他
`git status`查看一下状态

 git branch -d dev  删除分支
 git Switch  切换分支，在切换功能上和check out 相同；但是由于checkout功能更底层更多，有时候切换场景使用check out会造成困惑

### 基础操作
https://www.liaoxuefeng.com/wiki/896043488029600/896827951938304
初始化一个Git仓库，使用`git init`命令。

添加文件到Git仓库，分两步：

1.  使用命令`git add <file>`，注意，可反复多次使用，添加多个文件；
2.  使用命令`git commit -m <message>`，完成。
```
$ git add readme.txt     # 第一步

$ git commit -m "wrote a readme file"   # 第二步

```



### 版本
每一个commit 版本都可以被恢复
Git也是一样，每当你觉得文件修改到一定程度的时候，就可以“保存一个快照”，这个快照在Git中被称为`commit`。一旦你把文件改乱了，或者误删了文件，还可以从最近的一个`commit`恢复，然后继续工作，而不是把几个月的工作成果全部丢失。

#### 查看记录
`git log`命令查看改动commit历史记录，每个版本中的改动部分


`git log  --pretty=oneline`  优化呈现格式
```
$ git log --pretty=oneline
```

#### 回退
使用`git reset`命令`git reset --hard HEAD^ `

1094a  为之前版本号，不需要输全；所以你让`HEAD`指向哪个版本号，你就把当前版本定位在哪
```
$ git reset --hard 1094a 
```

查看回退记录：Git提供了一个命令`git reflog`用来记录你的每一次命令






### 版本管理
https://blog.csdn.net/weixin_43264399/article/details/87350219

当Git无法自动合并分支时，就必须首先解决冲突。解决冲突后，再提交，合并完成。

解决冲突就是把Git合并失败的文件手动编辑为我们希望的内容，再提交。

用`git log --graph`命令可以看到分支合并图。


#### 版本库
版本库又名仓库，英文名**repository**，你可以简单理解成一个目录，这个目录里面的所有文件都可以被Git管理起来，每个文件的修改、删除，Git都能跟踪，以便任何时刻都可以追踪历史，或者在将来某个时刻可以“还原”。

通过`git init`命令把这个目录变成Git可以管理的仓库
#### 版本回退
Git的版本库里存了很多东西，其中最重要的就是称为stage（或者叫index）的暂存区，还有Git为我们自动创建的第一个分支`master`，以及指向`master`的一个指针叫`HEAD`。
前面讲了我们把文件往Git版本库里添加的时候，是分两步执行的：
第一步是用`git add`把文件添加进去，实际上就是把文件修改添加到暂存区；
第二步是用`git commit`提交更改，实际上就是把暂存区的所有内容提交到当前分支。
因为我们创建Git版本库时，Git自动为我们创建了唯一一个`master`分支，所以，现在，`git commit`就是往`master`分支上提交更改。
![[Pasted image 20230330081816.png|300]]



#### 管理修改
##### *查看差异*
Git跟踪并管理的是修改，而非文件；更准确地是git 管理的是commit到暂存区stage的修改
提交后，用`git diff HEAD -- readme.txt`命令可以查看工作区和版本库里面最新版本的区别：


##### *撤销修改*
Git会告诉你，`git checkout -- file`可以丢弃工作区的修改：

```
$ git checkout -- readme.txt
```

命令`git checkout -- readme.txt`意思就是，把`readme.txt`文件在工作区的修改全部撤销，这里有两种情况：
1. 一种是`readme.txt`自修改后还没有被放到暂存区，现在，撤销修改就回到和版本库一模一样的状态；
2. 一种是`readme.txt`已经添加到暂存区后，又作了修改，现在，撤销修改就回到添加到暂存区后的状态。
总之，就是让这个文件回到最近一次`git commit`或`git add`时的状态。

`git checkout -- file`命令中的`--`很重要，没有`--`，就变成了“切换到另一个分支”的命令，我们在后面的分支管理中会再次遇到`git checkout`命令。


##### *删除*
删除也是一个修改操作，假设在工作区删除了 一个 test.txt
命令`git rm`用于删除一个文件。如果一个文件已经被提交到版本库，那么你永远不用担心误删，但是要小心，你只能恢复文件到最新版本，你会丢失**最近一次提交后你修改的内容**。

1. 一是确实要从版本库中删除该文件，那就用命令`git rm`删掉，并且`git commit`：
2. 另一种情况是删错了，因为版本库里还有呢，所以可以很轻松地把误删的文件恢复到最新版本：

```
$ git checkout -- test.txt
```






---------
### 分支管理

提交 版本
main 指针  <--head
dev 指针   <--head

#### 分支创建和修改branch\checkout

>
  branch 1、创建  2、查看当前branch  ，当前分支前会有星号
  checkout 切换   

首先，我们创建`dev`分支，然后切换到`dev`分支：

```
$ git checkout -b dev
Switched to a new branch 'dev'
```

`git checkout`命令加上`-b`参数表示**创建并切换**，相当于以下两条命令：

```
$ git branch dev
$ git checkout dev
Switched to branch 'dev'
```

然后，用`git branch`命令查看当前分支：  `git branch`命令会列出所有分支，当前分支前面会标一个`*`号

```
$ git branch
* dev
  master
```


`git branch`命令会列出所有分支，当前分支前面会标一个`*`号。

然后，我们就可以在`dev`分支上正常提交，比如对`readme.txt`做个修改，加上一行：

```
Creating a new branch is quick.
```

然后提交：

```
$ git add readme.txt 
$ git commit -m "branch test"
[dev b17d20e] branch test
 1 file changed, 1 insertion(+)
```

现在，`dev`分支的工作完成，我们就可以切换回`master`分支：

```
$ git checkout master
Switched to branch 'master'
```

切换回`master`分支后，再查看一个`readme.txt`文件，刚才添加的内容不见了！因为那个提交是在`dev`分支上，而`master`分支此刻的提交点并没有变：


#### 合并 merge

`git merge`命令用于合并指定分支到当前分支。合并后，再查看`readme.txt`的内容，就可以看到，和`dev`分支的最新提交是完全一样的。

注意到上面的`Fast-forward`信息，Git告诉我们，这次合并是“快进模式”，也就是直接把`master`指向`dev`的当前提交，所以合并速度非常快。

当然，也不是每次合并都能`Fast-forward`，我们后面会讲其他方式的合并。

合并完成后，就可以放心地删除`dev`分支了：

```
$ git branch -d dev
Deleted branch dev (was b17d20e).
```

删除后，查看`branch`，就只剩下`master`分支了：

```
$ git branch
* master
```

因为创建、合并和删除分支非常快，所以Git鼓励你使用分支完成某个任务，合并后再删掉分支，这和直接在`master`分支上工作效果是一样的，但过程更安全。

#### 冲突管理

一般我们想要本地仓库与远程关联起来，有两种办法：

1.  以远程仓库为准(本地仓库废弃)，直接拉下来代码即可；
2.  以本地仓库为准(远程仓库废弃)，强制推到远程；



##### 远程覆盖本地
[操作教程](https://blog.csdn.net/weixin_43264399/article/details/87350219)

**解决办法**：`git pull --rebase origin master` （该命令的意思是把远程库中的更新合并到（pull=fetch+merge）本地库中，--`rebase`的作用是取消掉本地库中刚刚的`commit`，并把他们接到更新后的版本库之中）


##### 本地强行覆盖远程
[Mannual](https://blog.csdn.net/DovSnier/article/details/107156612)
git push origin master --force

    git branch -u origin/master master



#### 分支管理策略

1. 默认策略：Git会用`Fast forward`模式，但这种模式下，删除分支后，会丢掉分支信息。
2. 团队管理策略: ```$ git merge --no-ff -m "merge with no-ff" dev ```
合并分支时，加上`--no-ff`参数就可以用普通模式合并，合并后的历史有分支，能看出来曾经做过合并，而`fast forward`合并就看不出来曾经做过合并

几个基本原则进行分支管理：

首先，`master`分支应该是非常稳定的，也就是仅用来发布新版本，平时不能在上面干活；

那在哪干活呢？干活都在`dev`分支上，也就是说，`dev`分支是不稳定的，到某个时候，比如1.0版本发布时，再把`dev`分支合并到`master`上，在`master`分支发布1.0版本；

你和你的小伙伴们每个人都在`dev`分支上干活，每个人都有自己的分支，时不时地往`dev`分支上合并就可以了。

所以，团队合作的分支看起来就像这样：

![git-br-policy](https://www.liaoxuefeng.com/files/attachments/919023260793600/0)





#### Rebase
https://www.liaoxuefeng.com/wiki/896043488029600/1216289527823648

这就是rebase操作的特点：把分叉的提交历史“整理”成一条直线，看上去更直观。缺点是本地的分叉提交已经被修改过了。

