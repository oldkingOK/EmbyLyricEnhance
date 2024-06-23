process_file() {
    local file="$1"
    local add_content="$2"
    local end_content="$3"

    # Backup
    if [ ! -f "${file}.bak" ]; then
        cp "${file}" "${file}.bak"
    fi

    # read
    local content
    content=$(cat "$file")
    local len=${#content}

    # Important: `;`
    local new_content="${content:0:len-${#end_content}};$add_content$end_content"
    echo -n "$new_content" > "$file"
}

file0='/system/dashboard-ui/modules/emby-elements/emby-itemscontainer/emby-itemscontainer.js'
file0_add='var o_onDataFetched=onDataFetched,onDataFetched=function(o){if(o.Items&&o.Items.length&&"LyricsLine"==o.Items[0].Type){var s=[],i=o.Items;i.sort((t,e)=>t.StartPositionTicks-e.StartPositionTicks);for(let t=0,e=o.Items.length;t<e;t++){for(var a=i[t];i[t+1]&&a.StartPositionTicks==i[t+1].StartPositionTicks;)a.Text=a.Text+"<br>"+i[t+1].Text,t++;s.push(a)}o.Items=s}return o_onDataFetched.apply(this,[o])};'
file0_end='});'
process_file "$file0" "$file0_add" "$file0_end"

file1='/system/dashboard-ui/modules/listview/listview.js'
file1_add='var o_getListItemHtml=getListItemHtml,getListItemHtml=function(t,e,m){e=o_getListItemHtml.apply(this,[t,e,m]);return"LyricsLine"!=t.Type?e:((m=document.createElement("textarea")).innerHTML=e,m.value)};'
file1_end='});'
process_file "$file1" "$file1_add" "$file1_end"
