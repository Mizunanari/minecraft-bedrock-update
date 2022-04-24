#!/bin/bash
# latest ファイルがない場合は作る
if [ ! -e "/opt/minecraft/mzip/latest" ]; then
  echo "none" > /opt/minecraft/mzip/latest
fi
# ダウンロードページ取得
curl -A "Mozilla/5.0 (X11; Linux x86_64)" https://www.minecraft.net/ja-jp/download/server/bedrock > /opt/minecraft/mzip/download.html
# リンクがあるタグを取得
ATAG=`cat /opt/minecraft/mzip/download.html | grep bin-linux`
# a タグの先頭を削除
DELA=${ATAG#*\"}
# a タグの残りを削除して URL を取得
D_URL=${DELA%%\"*}
# 今サーバーにインストールされているバージョンの URL
LATEST=`cat /opt/minecraft/mzip/latest`
# 今のバージョンが最新かチェック
if [ $D_URL = $LATEST ]; then
  # 最新なら何もしない
  exit
fi
# 最新じゃなければ zip ダウンロード
# TODO: ここでバックアップなどを行う
wget -P /opt/minecraft/mzip/ $D_URL
# zip ファイルのファイル名を取得
Z_FILE=${D_URL##*/}
# zip ファイルを解凍（-o で上書き）
unzip -o $Z_FILE -d /opt/minecraft/
# 更新したバージョンを書き込む
echo $D_URL > latest