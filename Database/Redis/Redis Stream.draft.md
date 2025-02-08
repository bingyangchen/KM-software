>[!Info] 官方文件
><https://redis.io/docs/latest/develop/data-types/streams/>

Redis stream 是 Redis 5.0 後新增的資料結構，行為像是一個 append-only log，但相較於傳統的 append-only log 有一些優勢，包括：

- 在 Redis stream 中搜尋的時間複雜度是 $O(1)$。
- Redis stream 支援包括 "fan out"、"consumer group" 等多種 consumption strategies。

綜合上述優點，可以發現 Redis stream ==是一種適合用來實作 message queue 的資料結構==。

# Entry ID

Redis stream 中的每一筆資料稱為一個 "stream entry"，每個 entry 都會有一個與 timestamp 掛鉤的 unique ID，其結構為：

```plaintext
{UNIX_TIMESTAMP_IN_MS}-{SEQ_NO}
```

同一毫秒生成的 entries 的 `{SEQ_NO}` 會從 0 開始遞增，而 `{SEQ_NO}` 有 64 bits（最大可以到 $2^{64} - 1$）所以實務上不可能有相同的 entry ID。

# 新增 Entry

```redis
XADD
```

- Time complexity: $O(1)$

# Query Entries

```redis
XRANGE {START_ID} {END_ID} [COUNT {M}]
```

- Time complexity: $O(\log(n) + m)$
    - n: total entries count
    - m: retrieved entries count

預設的撈取範圍是 "inclusive"（撈取的內容會包括 `{START_ID}` 與 `{END_ID}`）若要 exclusive 則須加上 `(` 或 `)`，比如：`XRANGE (1692632147973 1692632148000`（去頭）或 `XRANGE 1692632147973 1692632148000)`（去尾）。

`-` 和 `+` 是特殊的 ID，分別代表「第一筆資料」與「最後一筆資料」。
