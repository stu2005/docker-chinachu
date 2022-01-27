# docker-chinachu
chinachu γ (https://github.com/Chinachu/Chinachu) のDockerイメージです。https://hub.docker.com/r/stu2005/chinachu
毎日0時0分にイメージを更新します。
# 含まれているもの
・chinachu (./chinachu installerの2と4を実行しています)
・ffmpeg
# インストール
```
gti clone https://github.com/stu2005/docker-chinachu.git
cd docker-chinachu
docker compose pull
sudo mkdir -p /opt/mirakurun/run /opt/mirakurun/opt /opt/mirakurun/config /opt/mirakurun/data
docker compose run --rm -e SETUP=true mirakurun
docker compose up -d
```
# 使い方
mirakurunの部分は公式のイメージをそのまま使用しているのでそちらのドキュメントをご覧ください。 (https://github.com/Chinachu/Mirakurun)

・chinachu

何のファイルがどこにあるかはdocker-compose.ymlをみてください。`config.json`は`chinachu/config`以下にあります。mirakurunのurlとポート番号以外はご自身の環境に合わせてください。 (https://github.com/Chinachu/Chinachu/wiki/Gamma-Configuration)
# 操作方法
```
#起動
docker compose start
#終了
docker compose stop
#自動起動を解除
docker compose down
#アンスト
docker compose down --rmi all
#更新
docker compose pull
docker compose up -d
docker container prune -f
docker image prune -f

```
