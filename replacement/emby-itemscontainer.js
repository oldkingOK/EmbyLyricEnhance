;var o_onDataFetched = onDataFetched;
var onDataFetched = function(result) {
    if (result.Items && result.Items.length && result.Items[0].Type == `LyricsLine`) {
        let newItems = [], items = result.Items;
        items.sort((a, b) => a.StartPositionTicks - b.StartPositionTicks);
        for (let i = 0, length = result.Items.length; i < length; i++) {
            let item = items[i];
            while (items[i+1] && item.StartPositionTicks == items[i+1].StartPositionTicks) {
                item.Text = item.Text + "<br>" + items[i+1].Text
                i++;
            };
            newItems.push(item);
        }
        result.Items = newItems;
    }
    return o_onDataFetched.apply(this, [result]);
}
