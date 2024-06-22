# 开发日志

调试、打断点、看堆栈和调用链，得出关键信息如下：

在歌词渲染的过程中

 `listview.js` 文件的 `function getItemsHtml` 负责将歌词用  `list` 的 html 包裹住

 `emby-itemscontainer.js` 的 `function onDataFetched` 负责处理从后端Fetch到的信息
