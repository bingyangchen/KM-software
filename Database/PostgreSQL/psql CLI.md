### 進入 psql CLI

^136bc7

```bash
psql <db_name>

# 若沒有寫 db_name 就連到預設的 db
psql
```

在 MacOS 中的 `~/.zprofile` 或 `~/.zshrc` 中加入 environment variable 可以設定預設要連到哪個 database，比如：

```bash
export PGDATABASE=postgres
```

這樣就會預設連到名為 `postgres` 的 database。

---

### 離開 psql CLI：`\q`

這並不會停止 PostgreSQL server，只是離開 CLI。若要停止 server，請參考 [[Database/PostgreSQL/安裝與啟用#^0a8583|此處]]

---

### 列出所有 Database：`\l`

---

### 連線至指定 Database：`\c`

---

### 列出目前連線的 Database 的所有 Tables：`\dt`

---

### 查看所有 psql 指令：`\?`

---

# 參考資料

<https://www.postgresql.org/docs/current/app-psql.html>
