var o_getListItemHtml = getListItemHtml;
var getListItemHtml = function(item, index, options) {
    // 格式化html，防止html标签被转义
    let tmpResult = o_getListItemHtml.apply(this, [item, index, options]);
    if (item.Type != "LyricsLine") return tmpResult
    let tmpTextArea = document.createElement('textarea');
    tmpTextArea.innerHTML = tmpResult;
    return tmpTextArea.value;
}