# Installation

### On Linux Ubuntu

```bash
```

#TODO 

### On MacOS

- Step1: 安裝

    ```bash
    brew update && brew install mysql
    ```

- Step2: 啟動 MySQL server

    ```bash
    brew services start mysql
    ```

# MySQL CLI

### 進入 MySQL CLI

```bash
mysql {DB_NAME}
# or
mysql --user={USERNAME} --password {DB_NAME}
# or
mysql {DB_NAME} -u {USERNAME} -p
```

- 輸入有 `--password`/`-p` 的指令後，會被要求輸入 `{USERNAME}` 的密碼。若要使用的 user 不需要密碼即可登入，則不須加上 `--password`/`-p`。
- 剛安裝 MySQL 時，只會有一個名為 `root` 的 user 與一個名為 `mysql` 的 database。

### 離開 MySQL CLI

```bash
\q
# or
quit
# or
exit
```

# Connect with URL

### URL Format

```plaintext
{PROTOCOL}://[{DB_USER_CREDENTIAL}@]{HOST_URL}[:{PORT}][/{DB_NAME}]
```

e.g.

```plaintext
mysql+mysqldb://root:secret@localhost:3306/testing_db
```

- 若不提供 `{DB_USER_CREDENTIAL}`，則會使用目前的 OS user（若 MySQL 內不存在與 OS user 同名的 user 就會跳錯誤）。
- 若不提供 `{PORT}`，則預設為 `3306`，因為 ==MySQL 預設使用 port `3306`==。
- 若不提供 `{DB_NAME}`，則直接連上 host，可以再用 SQL `USE {DB_NAME};` 來連上指定 db。

### Protocol

### User Credential

### Multiple Hosts
