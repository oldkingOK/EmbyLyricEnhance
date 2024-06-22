var codes = [
    {
        "name": "emby-itemscontainer.js",
        "path": "/system/dashboard-ui/modules/emby-elements/emby-itemscontainer/emby-itemscontainer.js",
        "endsWith": "});"
    },
    {
        "name": "listview.js",
        "path": "/system/dashboard-ui/modules/listview/listview.js",
        "endsWith": "});"
    },
]

let UglifyJS = require("uglify-js");
let fs = require("fs");

let process = fs.readFileSync("./preprocess.sh", "utf8");
let undo = ``;

for (let i = 0; i < codes.length; i++) {
    let codeInfo = codes[i];

    let code = fs.readFileSync("./replacement/"+codeInfo.name, "utf8");
    let result = UglifyJS.minify(code);

    undo += `cp ${codeInfo.path}.bak ${codeInfo.path}\n`

    process += `
file${i}='${codeInfo.path}'
file${i}_add='${result.code}'
file${i}_end='${codeInfo.endsWith}'
process_file "$file${i}" "$file${i}_add" "$file${i}_end"
`
}

fs.mkdirSync("./output", { recursive: true });
fs.writeFileSync("./output/output_process.sh", process);
fs.writeFileSync("./output/output_undo.sh", undo);