Cron 是 Linux OS 內建的排程系統，使用者將 **cron expression** 與要定時執行的指令寫入 Cron 的設定檔，Cron 就會根據 cron expression 定時執行指令。

# 名詞解釋

- **Cron Job**

    一個排程任務，包含執行時間（cron expression）和要執行的指令。

- **Crontab**

    Cron Table 的縮寫，是儲存 cron jobs 的設定檔。每個 OS user 都有自己的 crontab 檔案。

- **Cron Daemon**

    在背景持續運行的服務 (`crond`)，負責檢查和執行 crontab 中的 cron jobs。

- **Cron Expression**

    定義 job 執行時間的表達式（詳見下一段）。

# Cron Expression

Cron expression 由 `分`、`時`、`日`、`月`、`星期幾` 五個部分組成。

有以下幾種特殊字元可使用：

- `*`：表示所有值
- `,`：用來分隔一個欄位中的多個數字，e.g. `0,2,5`
- `-`：表示 range，e.g. `1-5`
- `/`：表示間隔值，e.g. `*/2`、`1-50/5`

Example:

```cron
* 9-14 * * MON-FRI 
```

### [Useful Tool: Crontab Guru](https://crontab.guru/)

# Shell 設定

預設情況下，Cron 會使用使用者的預設 Shell 來執行指令。如果需要指定特定的 Shell，可以在 Crontab 檔案的開頭加入以下設定：

```bash
SHELL=/bin/bash  # 或其他 Shell 路徑
```

# 常用指令

### 查看所有 Jobs

```bash
crontab -l
```

### 匯出

```bash
crontab -l > /PATH/TO/TARGET/FILE
```

### 匯入

```bash
crontab /PATH/TO/SOURCE/FILE
```

### 匯入至某個 User 的 Crontab

```bash
crontab -u USERNAME /PATH/TO/FILE
```

### 編輯

```bash
crontab -e
```

### 刪除所有 Jobs

```bash
crontab -r
```

### Gracefully Restart Cron

```bash
sudo systemctl reload cron
```

### Hard Restart Cron

```bash
sudo systemctl restart cron
```

### 查看與 Cron 相關的 System log

```bash
sudo grep cron /var/log/syslog
```

# 其它類似工具

### [[Airflow.canvas|Airflow]]

Airflow 是一款免費且 open source 的工具，最初由 Airbnb 公司開發，後來轉賣給 Apache。在 Airflow 中，可以設定流程（任務間的先後順序），且有 GUI 將流程與任務的執行狀況視覺化。
