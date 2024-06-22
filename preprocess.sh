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
