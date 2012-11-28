---
layout: defaults
title: RyuJin-on-js by zolunX10
tags: [melonJS, STG]
---
## hello, world
东方打多了自然会有"我要自己写个打飞机!"的想法, 然后机缘巧合某翻到了<http://dixq.net/rp/>这神一般的项目, 有多达60篇的教程不说, 还提供对应每篇的完整代码, 当时就泪流满面长跪不起... 

原游戏 龍神録 采用c++\DXLib编写. 而出于蛋疼的理由, 某在学习这个STG的同时试着把它移植到了html上, 于是有了这么一个Repo. 下文的笔记主要记录了其中STG的流程和架构的内容, 顺带有些melonJS的杂七杂八, 涉及到windows和dx的部分还请参阅原网站教程╮(￣▽￣)╭.

- Warning 1: 作者显然不懂日语, 所以代码外其他内容均使用[塞氏翻譯法](http://www.douban.com/note/136844746/)习得~(￣▽￣~)(~￣▽￣)~
- Warning 2: 本文假设读者具有基本的C++技能, 以及虽然代码蛋疼地使用CoffeeScript编写, 不过当成没有分号的js看就好了.

本着压迫自己的原则, 某尽量每周更新一次commit对应写一篇笔记, 阅读时可以配合checkout. 

## thanks to:
- 龍神録 http://dixq.net/rp/
- melonJS https://github.com/obiot/melonJS
