#!/bin/bash

# ダウンロードページ取得
curl -A "Mozilla/5.0 (X11; Linux x86_64)" https://www.minecraft.net/ja-jp/download/server/bedrock > ./download/download.html
# リンクがあるタグを取得
ATAG=`cat ./download/download.html | grep bin-linux`
# a タグの先頭を削除
DELA=${ATAG#*\"}
# a タグの残りを削除して URL を取得
D_URL=${DELA%%\"*}
# zipファイルを取得
wget -P ./download $D_URL
