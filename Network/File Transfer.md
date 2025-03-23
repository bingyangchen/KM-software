講到檔案傳輸或許大家心裡第一個冒出的名詞就是 FTP，FTP 確實是專門用來傳送檔案的網路協定，但其實除了它之外，還有很多協定都可以用來傳輸檔案，比如我們每天都在用的 HTTP/HTTPS，還有 SSH 世界中的 SCP。

# FTP

FTP 是 File Transfer Protocol 的縮寫，是專門用來傳送檔案的 [[OSI Model.draft#Application Layer (Layer 7)|application layer protocol]]。雖說使用 HTTP/HTTPS 也可以傳送檔案，但當要傳送的檔案很大時，FTP 會比較快。

FTP 使用 port 20 傳輸資料、port 21 傳輸指令，其使用的 transport layer protocol 與 network layer protocol 則是 TCP/IP，因為 L4 用的是 [[TCP.draft|TCP]] 不是 UDP，所以可以確保資料完整性。

常見的使用 FTP 下載檔案的方法有二：

1. 使用網頁瀏覽器
2. 使用專用的 FTP Client（比如 FileZilla）

### 使用 Chrome 透過 FTP 下載檔案

在網址列輸入 server 的 FTP address 後，你會看到畫面顯示 target directory 的內容，包括檔案及資料夾，點擊檔案即可下載。

### 使用 FileZilla 透過 FTP 下載及上傳檔案

輸入 host IP address/domain、username、password 以及 port 後即可連線。

透過拖曳的方式上傳或下載檔案。

如同 HTTP，如果結尾沒有 "S" 就代表資料是以明文傳輸，所以 FTP 不適合在 public network 使用。在 FileZilla 上可以選擇是否使用加密的管道，加密的管道包括稍後會提及的 SFTP 與 FTPS。

# SFTP

SFTP 指的是建立在 SSH「之上」的 FTP（不是 SSH 內建的功能），使用與 SSH 一樣的 port 22。

SFTP 與 FTP 的差別在於，SFTP 傳輸的內容會先在 source 被加密，然後在 destination 被解密，使用加密方式的是 symmetric encryption（取得 shared secret key 的流程請參考 [[SSH 基本概念#Key Exchange]]）。

### SFTP vs. FTPS

FTPS 之於 FTP，就有如 HTTPS 之餘 HTTP，也就是說，FTPS 就是使用 [[SSL & TLS|SSL/TLS]] 加密通道的 FTP，不過這也意味著要使用 FTPS 就要向 CA (certificate authority) 申請／購買憑證，並且設定你的 FTP server 去使用該憑證。

![[ftps-vs-sftp.png]]

根據統計，SFTP 比 FTPS 更廣泛被使用。

# SCP

SCP 是 Secure Copy Protocol 的縮寫，它是 SSH 內建的功能，因此使用 SCP 的前置作業相對較其它 protocol 少，只要 server 與 client 可以用 SSH 連線，就可以使用 SCP。

由於 SCP 是 SSH 內建的功能，因此它使用 port 與 SSH 同樣是 port 22。

一般而言，SCP 傳送檔案的速度會明顯地較其它 protocol 快，因為 SCP 的設計相對簡單（但它沒有因此犧牲安全性）。

通常是使用指令來進行 SCP 檔案傳輸，指令是 `scp`。使用 `scp` 前，不需要特別先使用 `ssh` 指令連線，因為連線指令已經包在 `scp` 裡面了，`scp` 的 command pattern 與 `cp` 類似：

```bash
scp [{OPTION}] [[{USERNAME}@]{SRC_IP}:]{PATH_TO_FILE} [[{USERNAME}@]{DEST_IP}:]{PATH_TO_FILE}
```

Source 與 destination 皆可以是相對路徑或絕對路徑，其中若在 server side 使用相對路徑，則出發點是指定 user 的 home directory (`~`)；若在 client side 使用相對路徑，則出發點是下 `scp` 指令的地方。以下提供幾個示範：

### 示範一：將 Local 的檔案複製到 Remote

```bash
scp ./test.txt my_user@my_server:./Desktop
```

可以透過另外聲明檔案名稱，來為複製出來的檔案重新命名：

```bash
scp ./test.txt my_user@my_server:./Desktop/copied_test.txt
```

### 示範二：將 Local 的目錄複製到 Remote

```bash
scp -r ./dir my_user@my_server:./Desktop
```

要複製整個 directory 就要使用 `-r` option。

也可以透過另外聲明一個「原本不存在目錄名稱」，為複製出來的目錄重新命名：

```bash
scp -r ./dir my_user@my_server:./Desktop/copied_dir
```

### 示範三：將 Remote 中的檔案複製到 Local

```bash
scp my_user@my_server:~/Desktop/test.txt ~/Desktop
```

同樣地，也可以將目錄從 server 複製到 client，也可以重新命名，規則與 client to server 時一樣，此處不再贅述。

# 參考資料

- <https://blog.invgate.com/what-is-scp-protocol-a-complete-guide>
- <https://www.msp360.com/resources/blog/sftp-vs-ftps/>
