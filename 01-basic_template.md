---
layout: defaults
title: 基本框架
tags: [melonJS, STG]
---
# RyuJin系列笔记01: 搭建基本框架
> commit: ef7722ca

首页提过, 这是一个从c++输出为js的蛋疼demo, 于是系列的笔记也分成了[原教程的<del>不靠谱</del>解读](#review)和[自己的坑爹笔记](#on_js)两部分, 均为自我满足所用所以写到哪算哪吧~(滚. 

## Review
<http://dixq.net/rp>原教程的前几篇都很简单, 初始c技能比较高的同学可以直接看01, 06.

### 利用規約
<http://dixq.net/rp/kiyaku.html> - 主要包含以下几点:

- 个人娱乐时: 随便用  
- 免费发放\当作素材投稿时: 在声明中保留<龙神录>相关规约  
- 商业\教育\收费发放时: 总之先联系原作者= =  

### 01 project及素材准备
介绍了教程附带vs工程的目录结构之类的东西. 

### 02 首先试着执行吧
如何写一个DXLib的 hello world. 稍微看过一点windows程序设计的就会觉得 WinMain() 这东西超眼熟的吧~ 用DXLib初始化屏幕(窗口), 然后分别处理游戏或键盘消息.   
附带的project2里实现了按Esc退出的功能.

### 03 全局变量的使用
基本是在讲C++和编程风格的东西 -- 要把函数按功能划分到独立文件里啊, 之类的. 代码中使用了简单的extern方法, 去搜索include和extern可以获得相关知识.

### 04 自机绘制
在 struct.h 中定义了玩家自机数据struct ch_t. 以及如何使用DXLib的 LoadDivGraph() 读入自机图像, DrawRotaGraphF() 绘制. 

### 05 声明的技巧
继续讲编程技巧, 利用 #ifdef 来自动处理extern. pass.

### 06 在主循环中根据不同情况调用相应函数
简单说就是在 ProcessLoop() 循环中追加 func_state 变量, 用于控制程序是显示标题画面还是正式的游戏画面. 

### 07 board绘制
board就是战斗画面外的计分牌所在的那个框框啦. 简单调用LoadGraph()和DrawGraph()即可.

---------------------

## On JS
为了提高本demo蛋疼指数, 除了melonJS某还使用了以下技术: 

- [SeaJS](http://seajs.org/) 管理脚本依赖, 具体体现就是所有脚本文件都是形如  
`define(function(require, exports) { ... })`  
扩起. 
- [CoffeeScript](http://coffeescript.org/) 仅仅是把它当成不用写分号和花括号的js sugar使用, 简单粗暴地在 *lib/* 目录下  
`$ coffee -bc lib/*.coffee`  
编译生成js即可. 

本次commit实现了基本的画面绘制, 如下图:  
![自机有动画的哦!](http://ww3.sinaimg.cn/mw690/71b36129jw1dz9xl7a2zej.jpg)

程序入口为 main.coffee , 其实就比me lonJS自带的tutorial_template多写了那么几行`me.game.add()`而已: 

```{% highlight coffeescript %}
# ...
# 绘制记分牌及边框
for board in this.board
  me.game.add(board, 1)
# 绘制自机
me.game.add(global.ch, 10)
{% endhighlight %}
```

边框board使用me.SpriteObject及相应图片绘制(顺便melonJS的[资源载入方法](http://www.melonjs.org/docs/symbols/me.loader.html#preload)真是相当亲切明了); 自机则由me.ObjectEntity扩展而来( entities.coffee ):

```{% highlight coffeescript %}
#...
settings.image = "char"		# me.loader预载入的
settings.spritewidth = 73
settings.spriteheight = 73
this.parent(x, y, settings)
{% endhighlight %}
```

主要注意的就是要手动调用父类构造函数`this.parent(x,y,settings)`传入初始坐标及参数. spritewidth和spriteheight控制单位尺寸, 因为自机每帧有不同的动画, 为了方便并非使用单独的图片而是一张拼接后的大图:  
![自机用图片](https://github.com/zolunx10/ryujin-on-js/raw/master/dat/img/char/0.png)  
(关于动画, 参见<http://www.melonjs.org/docs/symbols/me.AnimationSheet.html#addAnimation>说明.)

------

PS. 看过melonJS的话, 会发现它用到了一个叫Tiled的高端工具来制作地图(用过RM的表示真是相当怀念...), 然后用 me.entityPool 来控制spirit绘制. 而它实际干的事情:

- 把上面me.ObjectEntity用到的x,y,settings等参数存在Tiled的地图文件里.
- me.entityPool负责实例化这个ObjectEntity, 并控制它与当前地图的滚动\碰撞关系.  

STG里并不需要像平台游戏中的障碍物之类的东西, 所以某就不用Tiled而是手动写了. 