var o_onDataFetched = onDataFetched;
var onDataFetched = function(result) {
    if (result.Items && result.Items.length && result.Items[0].Type == `LyricsLine`) {
        let newItems = [], items = result.Items;
        for (let i = 0, length = result.Items.length; i < length - 1; i++) {
            let item = items[i];
            if (item.StartPositionTicks == items[i+1].StartPositionTicks) {
                item.Text = item.Text + "<br>" + items[i+1].Text
                i++;
            };
            newItems.push(item);
        }
        result.Items = newItems;
    }
    return o_onDataFetched.apply(this, [result]);
}
// END
