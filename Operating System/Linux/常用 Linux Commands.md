### `man <COMMAND>`

顯示指定指令的使用說明。

### `alias`

**列出所有 alias**：`alias`

**設定 alias**

開啟 `~/.zshrc` 並加入 alias 設定：

```plaintext
alias lss='ls -F1G'
```

### `ls [<OPTIONS>]`

- `ls -F`: 為不同種類的物件的名稱結尾加上不同符號

    Example Output:

    ```plaintext
    Applications/  Volumes/  etc@      sbin/
    Library/       bin/      home@     tmp@
    System/        cores/    opt/      usr/
    Users/         dev/      private/  var@
    ```

    - `/` $\to$ directory
    - `*` $\to$ executable
    - `@` $\to$ symbolic (soft) link
    - 什麼都沒有 $\to$ regular file
    - ...

- `ls -R`: Recursively 列出所有 subdirectories

- `ls -a`: 把以 `.` 開頭的隱藏檔案也列出來

- `ls -l`: 針對每個 directories 顯示更完整的資訊，詳見 [[存取權限與 chmod]]

---

### `cd <PATH>`

### `cp [-r | -f] <OLD> <NEW>`

### `rm [<OPTIONS>] <FILE | DIR>`

### `mv <OLD> <NEW>`

### `pwd`

### `touch [-m] <FILE>`

### `mkdir <DIR_NAME>`

### [[與「搜尋」相關的指令]]

### `chmod <...>`（詳見 [[存取權限與 chmod]]）

### `exit`

### `top`

監控系統資源使用狀況。

也可以使用 `htop`，但須額外安裝：`brew install htop`

### `unzip <ZIP_FILE>`

### `echo <STRING>`

### `cat <FILE>`

### `kill <PID>|<APP_NAME>`

### [[與網路相關的指令]]

### `history [<OPTIONS>]`

- `history -p`：清除 command 歷史紀錄

### `shred [<OPTIONS>] <FILE>`

### `tail [-n <LINE_NUM>] <FILE>`

### `head [-n <LINE_NUM>] <FILE>`

### `whoami`

印出目前的 Username，`echo $USER` 也可以達到同樣效果。

### `uname [-a]`

### `wget`

### `sudo <COMMAND>`

以 Superuser 的身份執行指令。

# 參考資料

- <https://www.macupdate.com/how-to/mac-terminal-commands-list>
- <https://kinsta.com/blog/linux-commands/>