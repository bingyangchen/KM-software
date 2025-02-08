Redis 針對 "data stored in in-memory storage is volatile" 這個缺點提供了一些解決方案，有 persistence options 與 replication 兩種做法：

# Persistence Options

>[! Info] 官方文件
><https://redis.io/docs/latest/operate/oss_and_stack/management/persistence/>

Redis 有提供一些機制避免 server restart 所造成的資料遺失，包含：

### Redis Database (RDB)

每隔一段時間拍一張 snapshot，以檔案 (dump.rdb) 的形式存在 disk 中，server restart 後可以快速把 snapshot 的資料復原。

### Append-Only File (AOF)

把每一個 operation 記錄在一個 log file 裡，server restart 後把所有 operations 依序執行一次。

---

通常在 server restart 後須要花很多時間來重新建置資料，所以實務上較少使用 persistence options，比較常用的是下面要介紹的 replication。
# Replication

Redis 所採取的 [[Database Replication|replication model]] 是 single-leader model。
