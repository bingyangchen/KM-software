# 使用 `which` 搜尋執行檔

這個指令用來搜尋指定執行檔的位置，但只會從[[Operating System/Shell/1 - Introduction#PATH|環境變數 PATH]] 中搜尋。

```bash
which [{OPTIONS}] {EXECUTABLE}
```

e.g.

```bash
which python
# /Users/bob/.pyenv/shims/python
```

### `-a` 回傳所有符合的結果

若有多個符合的結果則預設顯示第一個，若要顯示全部則需加上 `-a` option

### 延伸應用一：若搜尋到則直接執行

由於回傳的結果是該執行檔完整的 path，因此可以搭配 `eval $(...)` 來直接執行該執行檔：

```bash
eval $(which python)
```

### 延伸應用二：顯示執行檔的詳細資訊

`which` 指令找到的可能只是 [[File System#Soft (Symbolic) Links|soft link]]，可透過 `ls -l` 來確認：

```bash
ls -l $(which python)
# -rwxr-xr-x  1 bob  staff  183 Mar 18 16:18 /Users/bob/python
```

# 使用 `whereis` 搜尋指令

這個指令用來搜尋另一個指令的 binary、source 以及 manual page，但只會從環境變數 `PATH` 中搜尋。

```bash
whereis [{OPTIONS}] {COMMAND}
```

e.g.

```bash
whereis openssl
# openssl: /usr/bin/openssl /usr/share/man/man1/openssl.1
```

# 使用 `find` 搜尋各式檔案

```bash
find {ROOT_PATH} [{OPTION} {VALUE}]
```

這個指令會 recursively 搜尋 `{ROOT_PATH}` 底下的所有 subdirectories。

e.g.

```bash
# 搜尋當前目錄及其子目錄中，名為 myfile.py 的檔案
find myfile.py

# 搜尋 home directory 及其子目錄中，名為 myfile.py 的檔案
find ~ -name myfile.py

# 搜尋 home directory 及其子目錄中，以 .py 結尾，但路徑不包含 /packages/ 的檔案
find ~ -name '*.py' -not -path '*/packages/*'

# 搜尋 root directory 及其子目錄中，大小在 5MB 以上的所有檔案
find / -size +5M

# 搜尋 ~/Desktop 及其子目錄中的所有一般檔案
find ~/Desktop -type f

# 對找到的 files 都執行 rm
find ~ -name '*.py' -exec rm {} \;
```

Option 為 `-type` 時，value 可以有以下值：

|`-type`|`b`|`c`|`d`|`f`|`l`|`p`|`s`|`D`|
|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
|**檔案型態**|外接儲存裝置|I/O 裝置|Directory|一般檔案|Link|FIFO|Socket|Door|

# 使用 `grep` 搜尋文字

找到 input string 中所有包含欲搜尋字詞的行 (line)，並將這些 lines stdout。

```bash
grep [{OPTIONS}] '{PATTERN}' {FILE} [{FILE2} ...]
```

**常用的 Options**

|Option|Description|
|:--|---|
|`-c`|只 stdout 欲搜尋字詞出現的次數|
|`-E {PATTERN}`|使用 extended regexp 搜尋|
|`-i`|case insensitive|
|`-l`|只 stdout 包含欲搜尋字詞的檔案名稱|
|`-q`|Quite mode，若有搜尋到指定文字，則直接 exit，不 stdout|
|`-r`|若 `{FILE}` 是一個 directory 而不是檔案，則不加 `-r` 會報錯；但加了 `-r` 就變成搜尋指定 directory 中的所有檔案|
|`-v`|改為搜尋「不」包含指定字詞的部分|

### Examples

- Stdout test.py 中所有包含 "dev" 的 lines：

    ```bash
    grep 'dev' ./test.py
    ```

- Stdout 目前 directory 底下的所有檔案中，所有包含 "hi" 的 lines：

    ```bash
    grep 'hi' ./*
    # or
    grep 'hi' ./ -r
    ```

- 搜尋 `lsof` 的回傳結果

    ```bash
    lsof | grep -E '\t928(\d{2})'
    ```

- 使用 `grep -q` 搭配 `||` 作為是否繼續執行的條件

    ```bash
    echo "hello world" | grep -q "a" || echo "123"
    # 123
    ```

>[!Note]
>`grep` 只能進行搜尋，不能對字串進行進一步處理，若要對字串進行處理，須使用 `tr`（詳見[[用 tr 進行字串處理|這篇]]）。

# 參考資料

- <https://ithelp.ithome.com.tw/articles/10244816>
