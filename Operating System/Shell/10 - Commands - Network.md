# `ifconfig`

```bash
ifconfig
```

Example output:

```plaintext
.
.
.
en0: flags=8863<UP,BROADCAST,SMART,RUNNING,SIMPLEX,MULTICAST> mtu 1500
    options=400<CHANNEL_IO>
    ether 0c:e4:41:e5:cc:8f 
    inet6 fe80::866:7f6e:6f5d:4728%en0 prefixlen 64 secured scopeid 0xb 
    inet 192.168.50.88 netmask 0xffffff00 broadcast 192.168.50.255
    nd6 options=201<PERFORMNUD,DAD>
    media: autoselect
    status: active
.
.
.
```

這個指令會列出這台電腦上所有 network interfaces 的資訊，一個段落就是一個 interface，開頭的冒號前是 interface 的名稱，不同種類的 interface 會有不同名稱，比如 `en` 就代表無線網路的 interface。

每個段落都由若干個 key-value 組成，以下為幾個較常看的 keys 與其 value 的含義：

- `ether`：該 interface 的 MAC address
- `inet`：該 interface 的 IPv4 address
- `inet6`：該 interface 的 IPv6 address
- `status`：該 interface 目前是否啟用

# 可以給我你的 IP Address 嗎？

### 從 `ifconfig` 找 Local IP Address

`ifconfig` 的細節請看上一段。這裡須人工找到名為 `en0` 或 `en1` 且 `status: active` 的那個段落，然後找到底下的 `inet` (IPv4) 或 `inet6` (IPv6)。

### 用 `ipconfig getifaddr en0` 取得 Local IP Address

- 是 `ipconfig`，不是 `ifconfig`
- 如果輸入 `en0` 發現沒有輸出值，就換 `en1`

### 用 `curl ifconfig.me` 取得 Public IP Address

如果你所連到的網路在 [[IP & IP Address#NAT|NAT]] 底下，那就必須從外部才能知道自己的 public IP address，因此這裡要使用 `curl` 發 request 到 `https://ifconfig.me` 這個外部網站，取得自己的 public IP address 後 stdout。

其實並不是只有 `https://ifconfig.me` 可以查詢 public IP address，其它網站（如 `https://ipinfo.io`）甚至提供了更完整的資訊，所以也可以試試看 `curl ipinfo.io`。

>[!Note]
>關於 local IP address 與 public IP address 的差異，請看[[IP & IP Address|這篇]]。

# `curl {URL}`

`curl` 可以用來傳送資料給 server 以及接收從 server 來的資料，其支援包含 FILE, FTP, FTPS, HTTP, HTTPS, WS, WSS… 等幾乎所有你想得到的 protocols，是一個非常全面的指令。

`{URL}` 前面若沒加 protocol，`curl` 就會根據 `{URL}` 猜測最有可能的 protocol（通常是`http`）然後幫你加上去，例如：

```bash
curl www.google.com  # will become "http://www.google.com"
```

### 依規則連續發送 Requests

可以使用 `{}` 以及 `[]` 來連續發送多個 requests，其中使用 `{}` 時，裡面要用 `,` 分隔多個想迭代的 strings：

```bash
curl "http://site.{one,two,three}.com"
```

使用 `[]` 則是搭配 `-` 指定一個區間、搭配 `:` 指定間隔，間隔可以不寫（預設是 1）：

```bash
curl "http://example.com/file[1-10].txt"
# or
curl "http://example.com/file[a-z:2].txt"
```

請記得，使用這些花式的 URL 時，`{URL}` 的外面要用 `" "` 包住。

### 下載檔案

使用 `-o {LOCAL_FILE_NAME}` 或 `--output {LOCAL_FILE_NAME}` option，即可指定將 response 寫成檔案並命名為 `{LOCAL_FILE_NAME}`：

```bash
curl -o my_file https://example.com
```

如果搭配連發 requests 的操作，則可以在 `{LOCAL_FILE_NAME}` 中用變數 `#1`, `#2`, … 來代表第一區塊、第二區塊… 現在迭代到的 string：

```bash
curl "http://{site,host}.host[1-5].com" -o "#1_#2"
```

這樣一來 file name 就會是 site_1 ~ site_5, host_1 ~ host_5。

如果不想特別想檔案名稱，而是想直接採用檔案在 server 的名字，則可以使用 `-O {URL}`（大寫）或 `--remote-name {URL}`：

```bash
curl -O https://example.com/filename.txt
# 這樣下載下來的檔案在 local 也會叫 filename.txt
```

### 上傳檔案

使用 `-T {FILE_NAME}` 或 `--upload-file {FILE_NAME}` 來上傳檔案到 server，也可以搭配 `{}` 以及 `[]` 連續上傳多個檔案：

```bash
curl -T "img[1-1000].png" ftp://ftp.example.com/
```

上方範例是上傳 local 的 img1.png, img2.png, …, img1000.png 等 1000 個檔案到 `ftp.example.com` 這台 server，使用 protocol 的是 [[File Transfer#FTP|FTP]]。

# `wget`

```bash
wget [{OPTIONS}] {URL} [{URL2} ...]
```

`wget` 可以說是 `curl` 的閹割版，但針對「下載資料」提供了比 `curl` 更多的 options 以及更 reliable 的下載服務。

**常用的 Options**

- `-O {LOCAL_FILE_NAME}` 指定下載後的檔名

    請注意在 `curl` 中是使用 `-o`，但在 `wget` 是使用 `-O`。

- `-i {URL_LIST_FILE_NAME}` 匯入 URL 名單

    比如你可以將所有想下載的檔案來源條列在一個叫 `urls.txt` 的檔案中，然後使用 `wget -i ./urls.txt` 一次下載所有檔案。

- `-c` 接續下載沒載完的東西

    當所處環境的網路不穩定時，有可能東西下載到一半突然斷線，如果想要在恢復連線後接著從上次停下來的地方繼續而不要從頭下載一個新的，那就可以加上這個 option。

- `-b {LOG_FILE_NAME}` 背景下載

    需要一個 `{LOG_FILE_NAME}` 的原因是因為要將下載過程中原本要 stdout 的東西改為寫入檔案。

- 帶上使用者帳號密碼

    e.g.

    ```bash
    wget --http-user=my_user --http-password=my_password http://www.example.com/my_file
    # or
    wget --ftp-user=my_user --ftp-password=my_password ftp://ftp.example.com/my_file
    ```

- `--user-agent="{USER_AGENT}"` 偽裝為瀏覽器

    正常使用 `wget` 時下載檔案時，其 user agent 會顯示 `wget` 的版本資訊：

    ```plaintext
    66.249.79.20 - - [25/Aug/2017:09:42:44 +0800] "GET /gtwang-url-128.png HTTP/1.1" 200 5289 "-" "Wget/1.14 (linux-gnu)"
    ```

    若想要偽裝成瀏覽器，則可以這麼做：

    ```bash
    wget --user-agent="Mozilla/5.0 (Windows NT 6.1; Trident/7.0; rv:11.0) like Gecko" https://example.com/example.txt
    ```

### 把整個網站下載下來

使用四個 options 的組合技，就可以將指定網站整個下載下來：

```bash
wget --mirror -p --convert-links -P ./my_folder https://example.com/
```

由上面範例可見，四個 options 分別是：

- `--mirror`：下載整個網站
- `-p`：下載顯示網頁所需要的所有相關檔案
- `--convert-links`：將下載網頁中的超連結，轉換為 local directory 中的位置
- `-P {DIR}`：將下載的檔案放在 `{DIR}` 目錄下

### 參考資料

- <https://blog.gtwang.org/linux/linux-wget-command-download-web-pages-and-files-tutorial-examples/>

# `netstat`

`netstat` 可以用來查看網路連線的狀態。

### 查詢 Port 狀態的常用指令

```bash
# 列出所有 ports
netstat -a

# 列出所有 listening 狀態的 ports
netstat -l

# 列出所有 TCP ports
netstat -at  # 若把 a 換成 l 就是只看 listening 的

# 列出所有 UDP ports
netstat -au  # 若把 a 換成 l 就是只看 listening 的

# 不要做 DNS lookup: -n
netstat -an
```

Example output:

```plaintext
Active Internet connections (w/o servers)
Proto Recv-Q Send-Q Local Address         Foreign Address       State
tcp        0      0 localhost:42360       localhost:redis       CLOSE_WAIT
tcp      456      0 localhost:44870       localhost:59270       CLOSE_WAIT
tcp        0      0 localhost:35370       localhost:29200       ESTABLISHED
tcp        0      0 localhost:41436       localhost:29200       ESTABLISHED
tcp        0      0 localhost:6479        localhost:33172       FIN_WAIT2
  .      .      .         .                       .                .
  .      .      .         .                       .                .
  .      .      .         .                       .                .
```

### 查詢 Routing Table

```bash
netstat -r
```

這個指令的輸出會跟 `route -n` 一樣。

### 查詢 Network Interface 狀態

```bash
netstat -i

# 顯示較詳細的資訊，輸出會跟 ifconfig 一樣
netstat -ie
```

Example output of `netstat -i`:

```plaintext
Name       Mtu   Network       Address            Ipkts Ierrs    Opkts Oerrs  Coll
lo0        16384 <Link#1>                       5601464     0  5601464     0     0
lo0        16384 127           localhost        5601464     -  5601464     -     -
en0        1500  192.168.50    192.168.50.87   72801125     - 17626450     -     -
 .          .       .             .                 .     .        .     .      .
 .          .       .             .                 .     .        .     .      .
 .          .       .             .                 .     .        .     .      .
```

### 參考資料

- <https://blog.gtwang.org/linux/linux-netstat-command-examples/>

# `ping {HOST}`

- `ping` 使用 [[ICMP]] 來確認 destination host 是否可以在網路上被找到，因此 ==ping 成功只能代表 network routing 沒問題，並不代表該 host 可以正常提供服務==
- `{HOST}` 的部分可以填入 IP address 或 domain，但不可加上 protocol、path、port、query string 等額外資訊
- Destination host 收到 ping 後會回覆，這個回覆被稱為 pong

e.g.

```bash
ping www.google.com
```

Example output:

```plaintext
PING www.google.com (142.251.42.228): 56 data bytes
64 bytes from 142.251.42.228: icmp_seq=0 ttl=57 time=6.806 ms
64 bytes from 142.251.42.228: icmp_seq=1 ttl=57 time=14.924 ms
64 bytes from 142.251.42.228: icmp_seq=2 ttl=57 time=6.555 ms
64 bytes from 142.251.42.228: icmp_seq=3 ttl=57 time=14.044 ms
--- www.google.com ping statistics ---
4 packets transmitted, 4 packets received, 0.0% packet loss
round-trip min/avg/max/stddev = 6.555/10.582/14.924/3.915 ms
```

# `traceroute {HOST}`

`traceroute` 使用 [[ICMP]] 來取得自己到 destination host 的路徑（會經過哪些 routers）以及花費的時間。

e.g.

```bash
traceroute www.google.com
```

Example output:

```plaintext
traceroute to www.google.com (142.251.42.228), 64 hops max, 40 byte packets
 1  router.asus.com (192.168.50.1)  3.732 ms  4.024 ms  4.261 ms
 2  192.168.18.1 (192.168.18.1)  4.252 ms  4.300 ms  4.336 ms
 3  218-35-172-254.cm.dynamic.apol.com.tw (218.35.172.254)  10.899 ms  9.674 ms  7.398 ms
 4  10.254.0.213 (10.254.0.213)  5.327 ms  5.743 ms  5.391 ms
 5  10.254.0.61 (10.254.0.61)  10.638 ms  14.287 ms
    10.254.0.5 (10.254.0.5)  7.619 ms
 6  10.254.0.201 (10.254.0.201)  29.032 ms  27.352 ms  22.353 ms
 7  142.250.168.254 (142.250.168.254)  7.498 ms  6.665 ms  6.349 ms
 8  * * *
 9  209.85.245.64 (209.85.245.64)  13.882 ms
    142.251.226.168 (142.251.226.168)  8.775 ms
    142.251.77.86 (142.251.77.86)  6.618 ms
10  192.178.106.56 (192.178.106.56)  6.429 ms
    209.85.142.121 (209.85.142.121)  6.837 ms
    192.178.106.166 (192.178.106.166)  6.614 ms
11  tsa01s11-in-f4.1e100.net (142.251.42.228)  7.654 ms  9.140 ms
    192.178.105.197 (192.178.105.197)  7.543 ms
```

# `route`

### 取得離自己最近的 Router 的 Routing Table

```bash
route -n
```

Example output:

```plaintext
Kernel IP routing table
Destination     Gateway         Genmask         Flags Metric Ref    Use Iface
0.0.0.0         10.101.0.1      0.0.0.0         UG    100    0        0 eno1
     .             .               .              .     .     .      .    .
     .             .               .              .     .     .      .    .
     .             .               .              .     .     .      .    .
```

# `arp`

### 查詢本機的 [[MAC Address & ARP#ARP Table|ARP Table]]

```bash
arp -a
```

Example output:

```plaintext
router.asus.com (192.168.50.1) at 24:4b:fe:35:13:7c on en0 ifscope [ethernet]
```

# `dig {DOMAIN}`

- 查詢 `{DOMAIN}` 的 IP addresses（進行 [[DNS#DNS Lookup|DNS lookup]]）
- `+short` option 可以讓輸出更為簡潔（只保留 IPv4 address 的部分）

e.g.

```bash
dig +short www.google.com
```

Output:

```plaintext
74.125.24.99
74.125.24.147
74.125.24.104
74.125.24.105
74.125.24.106
74.125.24.103
```

# `nc`

`nc` 是一個全名為 [Netcat](https://netcat.sourceforge.net/) 的網路狀態檢查工具，可以用來發送、監聽 [[OSI Model.draft#Transport Layer (Layer 4)|transport layer (L4)]] 的網路封包。

**常用的 Options**

|Option|Description|
|:-:|---|
|`-l`|監聽指定 socket，沒給這個參數的話就是「發送」封包至該 socket|
|`-u`|使用 UDP，沒給這個參數的話預設是用 TCP|
|`-U`|聲明將使用 [[Socket & Port#Unix Domain Socket\|Unix Domain Socket]]|
|`-v`|give more verbose output|
|`-w {n}`|connect + read 最多等 `{n}` 秒。不能與 `-l` 併用。|

### 測試指定 Socket 是否開啟

```bash
nc -v {IP_ADDRESS} {PORT}
```

因為使用 `-v`，所以連線成功時會有提示：

```bash
Connection to 142.251.12.147 port 80 [tcp/http] succeeded!
```

### 發送訊息、傳送檔案

```bash
# sending plaintext message
echo {MESSAGE} | nc {IP_ADDRESS} {PORT}

# sending file
nc {IP_ADDRESS} {PORT} < {FILE}
```

### 監聽本機的指定 Socket

```bash
nc -l localhost {PORT}
# or
nc -l localhost {UNIX_DOMAIN_SOCKET}
```

這個指令在收到第一個 TCP 封包後就會關閉（有加 `-u` 的話就是收到第一個 UDP 封包後關閉），如果想要持續監聽，須搭配 `while true` 使用，比如：

```bash
while true; do nc -l localhost 8000; done
```

也可以在每次收到封包時都回覆一些文字，甚至一個檔案，比如：

```bash
while true; do echo "hello" | nc -l localhost 8000; done
# or
while true; do nc -l localhost 8000 < index.html; done
```

>[!Note]
>`nc` 是 L4 的指令，並不會為送出的 response 封包加上 HTTP header，但大部分瀏覽器只看得懂 HTTP 封包，所以這類瀏覽器會無法順利解析 `nc` 所回覆得內容。

當有封包送進指定的 socket 時，封包的內容會被導入 stdout，所以我們可以 redirect stdout，將內容寫成檔案，比如：

```bash
nc -l localhost 8000 > output.txt
```
