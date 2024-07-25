# ![preview](image/README/preview.png)

[中文说明](./README_CN.md)

EmbyLyricEnhance is a plugin for enhancing the display of lyrics in Emby.

- Bilingual lyrics highlighting in single block
- Parsing the html code in the lyrics

Emby version: 4.8.8.0

Limitations: Currently, this plugin cannot be loaded as a standalone JavaScript file. It can only be loaded by modifying the Emby program.

Welcome to submit issues and PRs!

## How To Use

[Edit Files](#edit-files) and [Refresh Cache](#refresh-cache)。

### Edit files

#### Manual Editing

> Remember to back up these two files.

Copy all the contents of [replacement/emby-itemscontainer.js](replacement/emby-itemscontainer.js) ,

Insert at the end of `dashboard-ui/modules/emby-elements/emby-itemscontainer/emby-itemscontainer.js` file before `});`

Copy all the contents of [replacement/listview.js](replacement/listview.js) ,

Insert at the end of `dashboard-ui/modules/listview/listview.js` file before `});`.

#### Automatic Editing in Docker Emby

If you are using the Docker version of Emby, you can run the script to modify it with one click.

```bash
docker ps # Find the container name
docker exec -it <container-name> /bin/sh
```

Copy the contents of [prebuild/output_process.sh](prebuild/output_process.sh), paste it and press Enter to run it.

Run [prebuild/output_undo.sh](./prebuild/output_undo.sh) to undo the changes.

You can also generate the script manually:

> In fact, I just compressed the JavaScript file and put it into the script template.

```bash
npm install uglify-js
node main.js
```

The script is output in the `output` folder

### Refresh Cache

> If the multilingual lyrics have been successfully displayed, you can ignore this step.

There are two ways:

1. Right click And click Inspect - Network - "Disable Cache"
2. Right click And click Inspect - Application - Storage - Clear site data

Then refresh the page.

## What This Plugin Does

- Hijack lyrics text loading and merge lyrics with the same "start time"
- Hijack the process of rendering lyrics into HTML and parse the HTML code in the lyrics

## In Addition

Share a lyrics css that I use myself, just paste it into the custom css in the settings

- Font size: 150% on PC, 100% on mobile
- Lyrics centered

```css
.listItem.lyricsItem {
	margin: 0 0;
	font-size: 150%;
}
.listItemBody.itemAction.listItemBody-noleftpadding.listItemBody-noverticalpadding.listItemBody-reduceypadding.listItemBody-1-lines {
    text-align: center;
}
:root{
	--lyrics-transform-origin: center center !important;
}
.vertical-list.itemsContainer.osdLyricsItemsContainer.padded-bottom{
	-webkit-padding-end: 0 !important;
    padding-inline-end: 0 !important;
}
@media(max-width:500px){
	.listItem.lyricsItem {
		font-size: 100%;
	}
}
```
