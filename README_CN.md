# ![preview](image/README/preview.png)

EmbyLyricEnhance 是一个用于增强 Emby 中歌词显示的插件。

- 双语歌词单块高亮显示
- 解析歌词中 html 代码

Emby 版本：4.8.8.0

目前无法做到独立加载 JavaScript 文件以装载该插件，只能修改 Emby 程序。

欢迎提交issue和pr！

## 如何使用

[修改文件](#修改文件) 和 [刷新缓存](#刷新缓存)。

### 修改文件

#### 手动修改

将 [replacement/emby-itemscontainer.js](replacement/emby-itemscontainer.js) 的所有内容复制，

插入到 `dashboard-ui/modules/emby-elements/emby-itemscontainer/emby-itemscontainer.js` 文件末尾的 `});` 之前

将 [replacement/listview.js](replacement/listview.js) 的所有内容复制，

插入到 `dashboard-ui/modules/listview/listview.js` 文件末尾的 `});` 之前

#### Docker Emby 自动修改

如果使用的是 Docker 版本的 Emby，可以运行脚本一键修改。

```bash
docker ps # 找到 container 名称
docker exec -it <container-name> /bin/sh # 把 container-name 换成容器的名称
```

复制 [prebuild/output_process.sh](prebuild/output_process.sh) 的内容，粘贴回车运行。

运行 [prebuild/output_undo.sh](./prebuild/output_undo.sh) 可以撤销更改。

也可以手动生成脚本：

> 其实只是把 js 压缩了放进脚本模板里

```bash
npm install uglify-js
node main.js
```

脚本输出于 `output` 文件夹

### 刷新缓存

> 如果此时已经成功显示多语歌词，可以忽略这一步

两种方法

1. 右键 检查——网络——“禁用缓存”
2. 右键 检查——应用程序——存储——清除网站数据

然后刷新页面

## 原理

- 劫持歌词文本加载，合并“开始时间”相同的歌词
- 劫持歌词渲染成 html 的过程，解析歌词里的 html 代码

## 另外

分享一个歌词css，粘贴到设置里的自定义css即可

- 字体大小：电脑端 150%，手机端 100%
- 歌词居中

```css
.listItem.lyricsItem {
	margin: 0 0;
	font-size: 150%;
}
.listItemBody.itemAction.listItemBody-noleftpadding.listItemBody-noverticalpadding.listItemBody-reduceypadding.listItemBody-1-lines {
    text-align: center;
}
:root{
	--lyrics-transform-origin: center center !important;
}
.vertical-list.itemsContainer.osdLyricsItemsContainer.padded-bottom{
	-webkit-padding-end: 0 !important;
    padding-inline-end: 0 !important;
}
@media(max-width:500px){
	.listItem.lyricsItem {
		font-size: 100%;
	}
}
```
