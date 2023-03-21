
### 基本

反引号： ```  ```
1.切换到英文输入法模式下
2.找到电脑键盘 Esc 下面的键
3.敲两下就出现了反引号


连接文章：两个方括号
```  [[]] ```
连接文章内的小结 `[]` 里面加 #
```  [[]] ```


代码块：反引号+语言名称
```md
import pandas as pd
```

```python
import pandas as pd
```


表格：`|`为表格列的分界 ； `--` 为表头和正文内容的分界；`：` 为对齐方式的定义

表头1|表头2|表头3
:----|----:|:----:
a|b|C

```sql
select  from   where  group by

```






脚注：对应注释在文章末尾
```md
Here's a simple footnote,[^1] and here's a longer one.[^bignote]

[^1]: meaningful!

[^bignote]: Here's one with multiple paragraphs and code.

    Indent paragraphs to include them in the footnote.

    `{ my code }`

    Add as many paragraphs as you like.
```
点赞[^hh]
要在文章尾部加上

[^hh]:点赞、投币、收藏

评论：
Use `%%` to enclose comments, which will be parsed as Markdown, but will not show up in the preview.

```md
Here is some inline comments: %%You can't see this text%% (Can't see it)

Here is a block comment:
%%
It can span
multiple lines
%%
```

Here is some inline comments: %%You can't see this text%% (can't see it in preview)

Here is a block comment: (can't see it in preview either)
%%
It can span
multiple lines
%%


其他字体：

斜体：*未来*

粗体：**未来**

下划线：<u>未来</u>

strikethrough: ~~未来~~

高亮：==未来==

行内代码：
``未来：行内代码``
`未来：行内代码`


### Obsidian URI links

#### `[[]] or [](url)`都可以链接
Markdown style links can be used to refer to either external objects, such as web pages, or an internal page or image.

```md
http://obsidian.md - automatic!
[Obsidian](http://obsidian.md)
```

http://obsidian.md - automatic!
[Obsidian](http://obsidian.md)


```md
[Link to note](obsidian://open?path=D:%2Fpath%2Fto%2Ffile.md)
```

[Link to note](obsidian://open?path=D:%2Fpath%2Fto%2Ffile.md)

`[]`中是链接在文章中的显示名称

#### `|` 可以重命名链接
```[[Using obsidian URI|Obsidian URI]] ```
``[[Using obsidian URI|Obsidian URI]] ``links can be used to open notes in Obsidian either from another Obsidian vault or another program.

For example, you can link to a file in a vault like so (please note the ``[[Using obsidian URI#Encoding|required encoding]]):``


### Embeds
Accepted file formats

Obsidian recognizes the following file formats right now:

1.  Markdown files: `md`;
2.  Image files: `png`, `jpg`, `jpeg`, `gif`, `bmp`, `svg`;
3.  Audio files: `mp3`, `webm`, `wav`, `m4a`, `ogg`, `3gp`, `flac`;
4.  Video files: `mp4`, `webm`, `ogv`;
5.  PDF files: `pdf`.

All these types of files can be [embedded](app://obsidian.md/Embed%20files) in a note.

#### Images

```md
![Engelbart](https://history-computer.com/ModernComputer/Basis/images/Engelbart.jpg)
```

![Engelbart](https://history-computer.com/ModernComputer/Basis/images/Engelbart.jpg)


#### Resize images
You can resize images using the following syntax:

For markdown images, use `![AltText|100x100](https://url/to/image.png)`

For embeds, use `![[image.png|100x100]]`

To have the image scale according to its aspect ratio, omit the height `![[image.png|100]]`



#### iframe：web page
"iframe" is a way to embed a web page in another. It's useful because Markdown can accept HTML, which is a simple language to construct the web pages we see every day.
For example:
```html
<iframe src="https://www.youtube.com/embed/NnTvZWp5Q7o"></iframe>
``` 
produces
<iframe src="https://www.youtube.com/embed/NnTvZWp5Q7o"></iframe>

The basic syntax is：
```html
<iframe src="INSERT YOUR URL HERE"></iframe>
```



#### Developer notes原理

The syntax is inspired by Markdown's image syntax. We had two observations:

1.  添加`!` 才能真正展示连接
2.  `[[My page]]` = `[My page](My page)`
3.  `![[My page]]` should be equivalent to `![My page](My page)` , which by the image convention, if the title is the same as the link, should display it.
4.   `[Image](link.png)` links to the image, but `![Image](link.png)` actually displays it.  
5.   The internal link syntax is based on this assumption: `[[My page]]` is a shortcut (or "syntactic sugar" if you will) for `[My page](My page)`.  

[b站视频](https://www.bilibili.com/video/BV1no4y1k7YT/?spm_id_from=333.788.b_7265636f5f6c697374.11)


``` sql
select a ,
    b.amt
	c
from 
where 

group by
```
