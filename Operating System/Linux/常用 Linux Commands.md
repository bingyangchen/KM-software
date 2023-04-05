### `man <COMMAND>`

顯示指定指令的使用說明。

### `alias [<SETTING>]`

### `ls [<OPTIONS>]`

- `-F`: 為不同種類的物件的名稱結尾加上不同符號

    - `/` $\to$ directory
    - `*` $\to$ executable
    - `@` $\to$ symbolic (soft) link
    - `=` $\to$ socket
    - `%` $\to$ whiteout
    - `|` $\to$ FIFO
    - 什麼都沒有 $\to$ normal file

    Example Output:

    ```plaintext
    Applications/  Volumes/  etc@      sbin/
    Library/       bin/      home@     tmp@
    System/        cores/    opt/      usr/
    Users/         dev/      private/  var@
    ```

- `-R`: Recursively 列出所有 subdirectories
- `-a`: 把以 `.` 開頭的隱藏檔案也列出來
- `-l`: 針對每個 directories 顯示更完整的資訊

    Example Output:

    ```plaintext
    total 10
    drwxrwxr-x  26 root  admin   832 Apr  3 22:38 Applications
    drwxr-xr-x  67 root  wheel  2144 Mar 20 17:24 Library
    drwxr-xr-x@ 10 root  wheel   320 Feb  9 17:39 System
    drwxr-xr-x   5 root  admin   160 Mar 14 16:23 Users
    drwxr-xr-x   3 root  wheel    96 Mar 20 13:49 Volumes
    drwxr-xr-x@ 39 root  wheel  1248 Feb  9 17:39 bin
    drwxr-xr-x   2 root  wheel    64 Feb  9 17:39 cores
    dr-xr-xr-x   4 root  wheel  4804 Mar 15 11:27 dev
    lrwxr-xr-x@  1 root  wheel    11 Feb  9 17:39 etc -> private/etc
    .
    .
    .
    ```

---

### `cd <PATH>`

### `cp [-r] <OLD> <NEW>`

### `rm [-r | -f] <FILE | DIRECTORY>`

### `mv <OLD> <NEW>`

### `pwd`

### `touch [-m] <FILE>`

### `which [-a] <EXECUTABLE_FILE>`

顯示指定執行檔的所在的位置。

e.g.

```bash
which python
```

- 若有多個符合的結果則預設顯示第一個，若要顯示全部則需加上 `-a` option
- 由於回傳的結果不只是該執行檔所在的 directory，而是該執行檔，因此可以搭配 `eval $(...)` 來直接執行該執行檔

    e.g.

    ```bash
    eval $(which python)
    ```

### `chmod <...>`

### `exit`

### `sudo <COMMAND>`

### `htop`

須額外安裝：`brew install htop`

監控系統資源使用狀況。

### `unzip <ZIP_FILE>`

### `echo <STRING>`

### `cat <FILE>`

### `kill <PID>|<APP_NAME>`

### `ping <IP>|<HOST_NAME>`

### `history`

### `shred [<OPTIONS>] <FILE>`

### `tail [-n <LINE_NUMBER>] <FILE>`

### `head [-n <LINE_NUMBER>] <FILE>`

### `grep [-c] <REGEX> <FILE>`

### `whoami`

印出目前的 Username，`echo $USER` 也可以達到同樣效果。

### `uname [-a]`

### `find <...>`

### `wget`

# 參考資料

- <https://kinsta.com/blog/linux-commands/>