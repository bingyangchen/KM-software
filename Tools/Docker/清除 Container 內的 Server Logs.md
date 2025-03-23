### 步驟一：列出所有 Containers，取得目標 Container 的 ID

```bash
docker ps
```

### 步驟二：找到目標 Container 的 Log File 位置

```bash
docker inspect --format="{{.LogPath}}" {CONTAINER_ID}
```

Example output:

```plaintext
/var/lib/docker/containers/57ef5c1...-json.log
```

這個路徑是 host's filesystem 上的檔案路徑，不是 container 內的路徑。

### 步驟三：將該檔案的內容清空

```bash
sudo echo "" > {PATH/TO/LOG/FILE}
```

如果將步驟二與三結合的話，指令就是：

```bash
sudo echo "" > $(docker inspect --format="{{.LogPath}}" {CONTAINER_ID})
```

Done!

# 參考資料

- <https://www.howtogeek.com/devops/how-to-clear-logs-of-running-docker-containers/>
