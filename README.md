# Emby lyric enhance

增强歌词显示

- 双语歌词
- 支持解析歌词中的html

![1719063610774](image/README/1719063610774.png)

## 一些信息

Emby 版本：4.8.8.0

欢迎提交issue和pr！

## 使用

### 1. 连接

ssh连接略

```bash
docker ps # 找到 container 名称
docker exec -it <container-name> /bin/sh # 把 container-name 换成容器的名称
```

### 2. 运行脚本

然后复制、粘贴脚本的内容，可以用已经编译好的，或者自己编译

#### 预编译的

在 `./prebuild/output_process.sh` 可以找到预编译的脚本，在 container 内运行即可

`./prebuild/output_undo.sh` 可以撤销更改

#### 编译

需要 node 环境

```bash
npm install uglify-js
node main.js
```

输出于 `./output` 

### 2. 刷新js缓存

两种方法

1. （临时）右键 检查——网络——“禁用缓存”——刷新页面
2. （永久）右键 检查——应用程序——存储——清除网站数据

## 原理

- 劫持歌词文本加载，合并“开始时间”相同的歌词
- 劫持歌词渲染成 html 的过程，强行解析歌词里的 html 代码

## 另外

分享一个自用的歌词css，粘贴到设置里的自定义css即可

- 字体大小：电脑端 150%，手机端 100%
- 歌词居中

```css
.listItem.lyricsItem {
	margin: 0 0;
	font-size: 150%;
}
.listItemBody{
	text-align: center
}
:root{
	--lyrics-transform-origin: center center !important;
}
.vertical-list.itemsContainer.osdLyricsItemsContainer.padded-bottom{
	-webkit-padding-end: 0 !important;
    padding-inline-end: 0 !important;
}
@media(max-width:400px){
	.listItem.lyricsItem {
		font-size: 100%;
	}
}
```
