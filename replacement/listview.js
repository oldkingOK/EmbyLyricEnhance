var o_getListItemHtml = getListItemHtml;
var getListItemHtml = function(item, index, options) {
    // 格式化html，例如 &lt;br&gt; -> <br>
    let tmpResult = o_getListItemHtml.apply(this, [item, index, options]);
    if (item.Type != "LyricsLine") return tmpResult
    let tmpTextArea = document.createElement('textarea');
    tmpTextArea.innerHTML = tmpResult;
    return tmpTextArea.value;
}