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
file0_add='var o_onDataFetched=onDataFetched,onDataFetched=function(a){if(a.Items&&a.Items.length&&"LyricsLine"==a.Items[0].Type){var s=[],n=a.Items;for(let t=0,e=a.Items.length;t<e-1;t++){var o=n[t];o.StartPositionTicks==n[t+1].StartPositionTicks&&(o.Text=o.Text+"<br>"+n[t+1].Text,t++),s.push(o)}a.Items=s}return o_onDataFetched.apply(this,[a])};'
file0_end='});'
process_file "$file0" "$file0_add" "$file0_end"

file1='/system/dashboard-ui/modules/listview/listview.js'
file1_add='var o_getListItemHtml=getListItemHtml,getListItemHtml=function(t,e,m){e=o_getListItemHtml.apply(this,[t,e,m]);return"LyricsLine"!=t.Type?e:((m=document.createElement("textarea")).innerHTML=e,m.value)};'
file1_end='});'
process_file "$file1" "$file1_add" "$file1_end"
