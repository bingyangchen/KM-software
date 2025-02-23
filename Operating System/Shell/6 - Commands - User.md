一個 Linux OS 中可以存在若干個 users，其中必定會有一個 user 叫做 `root`，`root` 擁有系統中的所有（最高）[[7 - Commands - Permission|權限]]，又叫做 superuser。

`root` 的權限是最高的，因此強烈建議平時不要以 `root` 身份登入系統，否則你執行的應用程式都會獲得 `root` 的權限（也就是所有權限）。

>外來的應用程式中永遠都有可能存在 bug 或是 malware，因此賦予它所有權限非常危險！

較好的做法是平時使用 non-root user 登入，有需要取得 `root` 才有的權限時，再行取得權限。

# 取得 `root` 權限

```bash
su
```

輸入指令後會被要求輸入 `root` user 的密碼，輸入正確後會進入一個新的 Shell（屬於當前 Shell 的 [[Operating System/Shell/1 - Introduction#Subshell|subshell]]）。

但光使用 `su` 並不會讓[[Operating System/Shell/1 - Introduction#Environment Variable|環境變數]]跟著變，讀取的 Shell 設定檔也還是原本 user 的 home directory 底下的設定檔，只是有了 `root` 的權限而已，如果要讓環境變數也變成 `root` 的，須在指令中加一個 `-`：

```bash
su -
```

`su -` 進入 Shell 的效果就和使用 `root` 登入系統並進入 Shell 一樣。

---

如果切換為 `root` 後只要簡單執行一個指令便離開 root Shell，可以使用 `-c` option，例如：

```bash
su - -c "ls"
```

# 取得其他 User 的權限

`root` 又叫 superuser，是所有 user 的管理者，因此 `su` 指令也可以用來取得任何一個 user 的權限：

```bash
su {USERNAME}
```

此時要輸入的密碼是 `{USERNAME}` 的密碼，不過如果已經以 `root` 身份登入（在 `root` 的 Shell 中），則不用另外輸入密碼。

# `sudo`

```bash
sudo [{OPTIONS}] {COMMAND}
```

`sudo` 的意思是「以指定使用者的身份執行指令」，在 options 中聲明要以哪個使用者的身份執行，預設是以 `root` user 的身份執行。

`sudo` 使用上與 `su -c` 類似，後面直接加上想執行的指令，比如：

```bash
sudo ls
```

但是在有 `|`、`>`、`<` … 等 operator 的情況下，`sudo` 的效果只會套用到 operator 左側的指令，比如：

```bash
sudo echo hello > myfile
```

上面這個指令的意思是「先以 `root` 的身份執行 `echo hello` 這個指令，再回到原使用者的身份將 `echo` 的輸出寫入 myfile 這個檔案」，所以若原使用者沒有 myfile 的 write 權限，Shell 就會顯示錯誤訊息 Permission denied。

以上面這個情境來說，有兩種解決方法：

- 法一：先切到新 Shell session

    ```bash
    # Enter a new Shell session
    sudo su
    
    # Enter the password of the current user.
    
    # In the new Shell session
    echo hello > myfile
    ```

- 法二：不切到新的 Shell session

    ```bash
    echo hello | sudo tee myfile
    ```

    - `tee [{FILE}]` 的功能是將 stdin 複製並送至 stdout，後面有放 file 則將 stdin 寫入 file
    - `sudo` 放在 `tee` 這邊

**常用的 Options**

|Option|Description|
|---|---|
|`-u {USERNAME}`|先取得指定 user 的權限，再執行指令|
|`-g {GROUP}`|先取的指定 group 的權限，再執行指令|

e.g.

```bash
sudo -u bob ls
```

### `sudo` 與 `su` 的差別在於輸入的密碼

- 使用 `su` 取得 user A 的權限時，須要輸入的 user A 的密碼
- 使用 `sudo` 則無論要取得誰的權限都是輸入「目前 user 的密碼」

### 誰可以用 `sudo`？

「使用 `sudo` 只須輸入目前 user 的密碼」這聽起來很危險對吧！如果所有 users 都可以使用 `sudo` 切成 `root`，又只須輸入自己的密碼，那豈不是所有 users 都可以取得所有權限嗎？

當然不是，事實上 Linux 系統中使用了 `/etc` 底下的 `sudoers` 檔案來限制哪些 users 可以使用 `sudo`，檔案中的 pattern 如下：

```plaintext
{USER1} {SOURCE_HOST}=({USER2}) {COMMAND}
```

這一行設定使得 `{USER1}` 可以從 `{SOURCE_HOST}` 登入 `{USER2}`，並且只能執行 `{COMMAND}` 這個指令。

如果要設定「`{USER1}` 可以從任意 host 登入任意 user，並使用任意 command」，則須設定為：

```plaintext
{USER1} ALL=(ALL) ALL
```

也可以設定群組的權限，須在最前面加一個 `@`：

```plaintext
@{GROUP} {SOURCE_HOST}=(USER2) {COMMAND}
```

> [!Note]
> `/etc/sudoers` 這個檔案只有具有 `root` 權限者可以修改，且若要修改，須使用 `visudo` 這個編輯器來修改，OS 會在編輯完成後自動檢查設定檔的語法是否正確，避免錯誤的語法導致 `sudo` 無法使用。

### `sudo` + `su`

```bash
# 透過 root 取得 root 的權限，並開啟新的 Shell session
sudo su

# 透過 root 取得 root 的權限與環境變數，並開啟新的 Shell session
sudo su -

# 透過 root 取得 "bob" user 的權限，並開啟新的 Shell session
sudo su bob

# 透過 root 取得 "bob" user 的權限與環境變數，並開啟新的 Shell session
sudo su bob -
```

# 新增 User

```bash
useradd [{OPTIONS}] {USERNAME}
```

**常用的 Options**

|Option|Description|
|---|---|
|`-g {MAIN_GROUP}`|指定 `{USERNAME}` 所屬的主要群組|
|`-G {ADDITIONAL_GROUP}`|指定 `{USERNAME}` 所屬的其它附加群組|
|`-e {DATE}`|指定 `{USERNAME}`  的使用期限|

e.g.

```bash
useradd -g enginners -G managers -e 2050-12-31 bob
```

# 刪除 User

```bash
userdel [-r] {USERNAME}
```

加上 `-r` option 代表要連同使用者的目錄一起刪除。

# 設定 User 的密碼

```bash
passwd {USERNAME}
```

> [!Note]
> 設定完密碼才算正式啟用 user。

# 修改 Username

```bash
usermod {OPTIONS} {USERNAME}
```

# 查詢指定 User 的資訊

```bash
id [{USERNAME}]
```

若不輸入 `{USERNAME}` 則代表查詢目前登入的使用者。

Example output:

```plaintext
uid=0(root) gid=0(wheel) groups=0(wheel), 1(daemon), 2(kmem), 3(sys), 4(tty),5(operator),8(procview),9(procmod),12(everyone),20(staff),29(certusers),61(localaccounts),80(admin),33(_appstore),98(_lpadmin),100(_lpoperator),204(_developer),250(_analyticsusers),395(com.apple.access_ftp),398(com.apple.access_screensharing),399(com.apple.access_ssh),400(com.apple.access_remote_ae),701(com.apple.sharepoint.group.1)
```

**常用的 Options**

|Option|Description|
|---|---|
|`-u`|回傳指定 user 的編號|
|`-un`|回傳指定 user 的 username|
|`-g`|查詢指定 user 所屬的主要群組的編號|
|`-gn`|查詢指定 user 所屬的主要群組的名稱|
|`-G`|查詢指定 user 所屬的附屬群組的編號|
|`-Gn`|查詢指定 user 所屬的主要群組的名稱|

使用 `groups` 指令也可以查詢所屬的附加群組：

```bash
groups [{USERNAME}]
```

### 查詢當前 User 的 Username

```bash
whoami
# or
echo $USER
```

# 列出所有 Users

使用下方指令可以列出所有使用者：

```bash
awk -F ':' '{print $1}' /etc/passwd
```

### 列出所有處於登入狀態的 Users

```bash
w
```

> [!Info]
> MacOS「新增／修改／刪除／查詢／列舉使用者與群組」的指令與 Linux 不同，詳細請見[[Tools/Mac/零碎筆記#如何建立透過 Terminal 一個 User|這裡]]。

# 參考資料

- <https://blog.gtwang.org/linux/sudo-su-command-tutorial-examples/>
- <https://ithelp.ithome.com.tw/articles/10245004>
