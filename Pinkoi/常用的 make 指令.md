[文件](https://paper.dropbox.com/doc/Python-3---B1Nt4b8m9ercJm3gSz3eXQ4oAg-vppbyr3tvi9pgr6BSx8tk)

### `make local-up`

#TODO 

### `make local-down`

#TODO 

### `make web-start`

開啟 py3 web gunicorn，~~會順便停止 py2 的 gunicorn~~ 

### `make web-logs`

顯示 py3 gunicorn 的 log，必需在 gunicorn 啟動狀態下才有用

### `make web-debug`

等於 `make web-start` + `make web-logs`。會讓 gunicorn 在前景 (foreground) 執行，並且有可操作的 tty 可以用鍵盤輸入進行互動 (e.g. `ctrl` + `c` 中斷/pdb）

### `make web-status`

顯示目前 py3 gunicorn 的啟動狀態

### `make web-stop`

停止 py3 gunicorn

### `make shell`

開啟一個 bash shell，裡面有設定好的 py3 環境，通常用於執行 script

### `make poetry-shell`

開啟可以使用 poetry 指令的 py3 的 shell，請不要在這個 shell 下進行 poetry 之外的操作

### `make python-container`

重新依據 `pyproject.toml` 以及 `poetry.lock` 建立新的 python docker image。

如果在非 dev 的 branch 下執行，會建立出該 branch 專屬的 python docker image。

所有的 `web-xxx` / `celery-xxx` 等 python 相關 `make` command 都會自動優先選擇目前所在 branch 的專屬 python docker image。

### `make celery-start`

開啟 py3 celery gunicorn，會順便停止 py2 的 celery 

### `make celery-logs`

顯示 py3 celery 的 log，必需在 celery 啟動狀態下才有用

### `make celery-debug`

等於 `make celery-start` + `make celery-logs`。會讓 celery 在前景 (foreground) 執行，並且有可操作的 tty 可以用鍵盤輸入進行互動 (e.g. `ctrl` + `c` 中斷）

### `make celery-status`

顯示目前 py3 celery 的啟動狀態

### `make celery-stop`

停止 py3 celery

### `make dev-assets`

使用 nodejs container build 出 dev 環境的前端 (`.js` + `.css`) 檔案 

### `make production-assets`

使用 nodejs container build 出 production 環境的前端 (`.js` + `.css`) 檔案 

### `make watch-website`

進入 webpack 的 watch mode (開發 buyer site 使用)

### `make watch-panel`

進入 webpack 的 watch mode (開發設計師後台使用)

### `make node-shell`

開啟一個 bash shell，裡面有設定好的 nodejs 環境。

### `make node-conatiner`

重新依據 `package.json` / `package.lock.json` 建立新的 nodejs docker image。

如果在非 dev 的 branch 下執行，會建立出該 branch 專屬的 node docker image。

所有的 nodejs 相關 `make` command 都會自動優先選擇目前所在 branch 的專屬 node docker image。

### `make vscode-remote-env`

產生給 remote vscode 使用的設定檔案 (for Python)

### `make vscode-local-env`

產生給 vscode 進行 local 開發的設定檔案 (for Python)

### `make py-test`

執行 pytest

### `make extract-intl`

從 codebase 中取出翻譯所需的 keys

### `make upload-pot`

將 `.pot` 檔上傳至 OneSky

### `make download-po`

從 OneSky 下載 `.po` 檔

### `make compile-intl`

將 `.po` 檔轉成 `.mo` 檔

### `make pull-local-registry`

從 local registry 更新最新的 docker images 

### `make sync-local-cert`

更新 local 開發 ssl 憑證

### `make local-proxy`

打開 local proxy，可將 local 開發的 server 透過 proxy share 給本機以外的使用者

### `make tunnel`

啟動 local 開發用的 ssh tunnel

### `make stop-tunnel`

停止 local 開發用的 ssh tunnel
