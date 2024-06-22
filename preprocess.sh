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
