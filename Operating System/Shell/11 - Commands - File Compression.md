以文字檔為例，現今的文字檔常見的是以 [[Character Encoding & Decoding#UTF-8|UTF-8]] 編碼，一個 character 會佔用到 2 bytes 甚至 3 bytes，然而一個 ASCII character 的大小其實只有 1 byte，因此一個 UTF-8 編碼文字檔中，ASCII character 的開頭會有很多個 `0` (leading zeros)，這樣其實很浪費空間。

而檔案壓縮其實就是透過把這些 leading zeros 的空間釋放出來，進而達到縮小檔案大小的效果。可以想像一個喝完的鋁箔包，中間是空的，壓扁後體積就縮小了。

Data Compression (Source Coding, or Bit-Rate Reduction) 的演算法有很多（詳見[[Data Compression Algorithms.draft|這篇]]），因此也有很多不同的壓縮檔案用的指令。

壓縮過的檔案無法直接使用，作業系統會不知道如何讀取／寫入／執行它們，因此每一種壓縮演算法都會有對應的「解壓縮」演算法。

在 Linux OS 中，不同的壓縮方式壓出來的 file extension 不同，但 file extension 並不會決定檔案本身的性質，只是方便人類辨識而已，常見的壓縮方式及 file extension 對應如下：

|指令|File Extension|演算法|
|---|---|---|
|[[#compress]]|`*.Z`|Modified Lempel-Ziv Algorithm|
|[[#gzip]]|`*.gz`|Lempel-Ziv Algorithm|
|[[#bzip2]]|`*.bz2`|Burrows-Wheeler Algorithm|
|[[#zip]]|`*.zip`||
|[[#rar]]|`*.rar`||

上述這些壓縮檔案的指令，一次都只能對單一個檔案進行壓縮，無法一次壓縮多個檔案，也無法壓縮一個資料夾，如果希望可以一次壓縮多個檔案或資料夾，我們須要先將它們「打包」(bundle)，相關指令如下：

|指令|File Extension|功能|
|---|---|---|
|`tar`|`*.tar`|打包|
|`tar` + `gzip`|`*.tar.gz`|打包＋壓縮|

# `compress`

### 壓縮

```bash
compress [{OPTIONS}] {FILE} [{FILE} ...]
```

`compress` 壓縮出來的檔案會直接取代掉原本的檔案，換句話說，原本的檔案壓完後就消失了。

預設情況下，使用 `compress` 壓縮檔案時，如果系統發現一個檔案被壓縮後的大小不減反增，則會自動放棄壓縮。

**常用的 Options**

|Option|Description|
|:-:|---|
|`-c`|直接 stdout 壓縮後的結果，不將壓縮結果存進檔案|
|`-f`|強制壓縮，就算壓縮完後檔案變大也照壓|
|`-v`|壓完後 stdout 檔案大小的變化百分比|
|`-d`|解壓縮|

### 解壓縮

```bash
compress -d {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
# or
uncompress {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
```

使用 `compress -d` 時可以不用寫出 file extension (`.Z`)；但使用 `uncompress` 就一定要寫 file extension。

# `gzip`

`gzip` 是比 `compress` 新一代的指令，其中的 "g" 代表的是 [[GNU]]。

### 壓縮

```bash
gzip [{OPTIONS}] {FILE} [{FILE} ...]
```

`gzip` 壓縮檔案時預設的行為也是會用壓縮檔取代掉原本的檔案，但可以用 option `-k` 調整這個行為。

**常用的 Options**

|Option|Description|
|:-:|---|
|`-1` ~ `-9`|數字越小代表壓縮速度越快，但壓縮效果越差；反之，數字越大則代表壓縮速度越慢，但壓縮效果越顯著，預設是 `-6`|
|`-c`|直接 stdout 壓縮後的結果，不將壓縮結果存進檔案|
|`-d`|解壓縮|
|`-k`|保留原檔案，將壓縮過的檔案另存|
|`-S {SUFFIX}`|指定壓縮後檔案的 file extension|
|`-v`|將壓縮的結果 stdout，包括壓縮比等|

### 解壓縮

```bash
gzip -d {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
# or
gunzip {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
```

`{FILE_COMPRESSED}` 的 file extension 可加可不加。

# `bzip2`

一般而言 `bzip2` 壓縮檔案的效果會比 `gzip` 顯著，其中 "b" 代表的是其使用的演算法：Burrows-Wheeler algorithm。

### 壓縮

```bash
bzip2 [{OPTIONS}] {FILE} [{FILE} ...]
```

`bzip2` 壓縮檔案時預設的行為也是會用壓縮檔取代掉原本的檔案，但可以用 option `-k` 調整這個行為。

*常用 Options 與 `gzip` 相同，此處不重複。*

### 解壓縮

```bash
bzip2 -d {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
# or
bunzip2 {FILE_COMPRESSED} [{FILE_COMPRESSED} ...]
```

與 `gzip` 不同的是，兩種方法的 `{FILE_COMPRESSED}` 都必須包含 file extension。

# `zcat` & `bzcat`

如果只是想 peek 解壓縮之後的內容，並不想實際解壓縮檔案並將其存檔，可以使用 `zcat` 或 `bzcat`：

```bash
zcat {FILE_COMPRESSED}
# or
bzcat {FILE_COMPRESSED}
```

其中 `zcat` 的 `{FILE_COMPRESSED}` 不用加 file extension，但 `bzcat` 的 `{FILE_COMPRESSED}` 要加 file extension。

> [!Note]
> `zcat` 只能解讀 file extension 為 `.Z` 的檔案，但並不一定要是 `compress` 壓出來的，也就是說你可以用其它指令壓縮檔案然後把 file extension 改為 `.Z`，這樣就可以用 `zcat` 解讀了。
>
> 同樣地，`bzcat` 只能解讀 file extension 為 `.bz2` 的檔案，但並不一定要是 `bzip2` 壓出來的。

# `tar`

`tar` 可以用來打包、壓縮並打包檔案以及資料夾。

### 打包

```bash
tar -cf {A} {B} [{C} ...]
```

將所有 `{B} [{C} ...]` 打包成一個叫做 `{A}` 的檔案，通常 `{A}` 會以 `.tar` 做為 file extension。

指令中的 `-c` option 用來打包，`-f` option 用來表示接著要開始輸入檔案名稱（`-f` 一定要放在所有 options 的最後面）。

打包完成後，原檔案不會消失。

### 打包並壓縮

```bash
tar -czf {A} {B} [{C} ...]
```

將所有 `{B} [{C} ...]` 打包並壓縮成一個叫做 `{A}` 的檔案，這裡使用的壓縮方法其實就是 `gzip`，也因此通常 `{A}` 會以 `.tar.gz` 做為 file extension。

指令中的 `-z` option 用來壓縮。

### 拆封與解壓縮

```bash
tar -xvf {BUNDLE_FILE}
```

`{BUNDLE_FILE}` 必須有 file extension，若是一個打包且壓縮過的檔案，則先將其解壓縮再拆封；若只是一個打包的檔案，則直接將其拆封。

指令中的 `-x` option 代表解壓縮與拆封，`-v` option 代表將過程 stdout。

# 參考資料

- <https://linux.vbird.org/linux_basic/mandrake9/0240tarcompress.php>
- <https://www.hy-star.com.tw/tech/linux/compress/compress.html>
