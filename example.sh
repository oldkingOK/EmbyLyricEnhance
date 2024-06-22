#!/bin/sh

# 定义函数
process_file() {
    local file="$1"
    local add_content="$2"
    local end_content="$3"

    # 备份文件
    if [ ! -f "${file}.bak" ]; then
        cp "${file}" "${file}.bak"
    fi

    # 读取文件内容到变量
    local content
    content=$(cat "$file")

    # 获取文件内容长度
    local len=${#content}

    # 构建新的文件内容，加分号防止和前面的内容冲突
    local new_content="${content:0:len-${#end_content}};$add_content$end_content"

    # 将新内容写回文件
    echo -n "$new_content" > "$file"
}

# 定义文件路径和要添加的内容
file1='/system/dashboard-ui/modules/listview/listview.js'
file1_add='var o_getListItemHtml=getListItemHtml,getListItemHtml=function(t,e,i){i=o_getListItemHtml.apply(this,[t,e,i]);if("LyricsLine"!=t.Type)return i;let m=document.createElement("textarea");return m.innerHTML=i,m.value};'
file1_end='});'

file2='/system/dashboard-ui/modules/emby-elements/emby-itemscontainer/emby-itemscontainer.js'
file2_add='var o_onDataFetched=onDataFetched,onDataFetched=function(n){if(n.Items&&n.Items.length&&n.Items[0].Type==`LyricsLine`){let s=[],a=n.Items;for(let e=0,t=n.Items.length;e<t-1;e++){let t=a[e];t.StartPositionTicks==a[e+1].StartPositionTicks&&(t.Text=t.Text+"<br>"+a[e+1].Text,e++),s.push(t)}n.Items=s}return o_onDataFetched.apply(this,[n])};'
file2_end='});'

# 调用函数处理文件
process_file "$file1" "$file1_add" "$file1_end"
process_file "$file2" "$file2_add" "$file2_end"
