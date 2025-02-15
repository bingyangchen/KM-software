Redis 支援多種資料結構，相對地另一個有名的 in-memory database - Memcached 只支援 string。

# String

==Redis 中沒有 integer 和 float 這兩種資料型態==，所有數字都會被轉為 string。

e.g.

```plaintext
> set age 20
OK

> get age
"20"
```

# List

支援 left push、left pop、right push 與 right pop，所以可以實現 queue 和 stack 等 [ADT](</Data Structures & Algorithms/ADT.draft.md>)。

e.g.

```plaintext
> rpush names Alice Bob
(integer) 2

> lrange names 0 -1
1) "Bob"
2) "Alice"
```

# Hash

以 key-value pair 做為某個 key 的 value，但最多就這兩層，無法繼續將 hash 中的某個 key 的 value 設為 hash。

e.g.

```plaintext
> hset person name Alice
(integer) 1

> hget person name
"Alice"
```

# Set

e.g.

```plaintext
> sadd words 1 2 2
(integer) 2

> smembers words
1) "1"
2) "2"
```

# Sorted Set

#TODO

# Bit Array

# Hyper Log

# Stream

Redis stream 是 Redis 5.0 後新增的資料結構，行為像是一個 append-only log，但相較於傳統的 append-only log 有一些優勢，包括：

- 在 Redis stream 中搜尋的時間複雜度是 $O(1)$。
- Redis stream 支援包括 "fan out"、"consumer group" 等多種 consumption strategies。

綜合上述優點，可以發現 Redis stream ==是一種適合用來實作 message queue 的資料結構==。

### Entry ID

Redis stream 中的每一筆資料稱為一個 "stream entry"，每個 entry 都會有一個與 timestamp 掛鉤的 unique ID，其結構為：

```plaintext
{UNIX_TIMESTAMP_IN_MS}-{SEQ_NO}
```

同一毫秒生成的 entries 的 `{SEQ_NO}` 會從 0 開始遞增，而 `{SEQ_NO}` 有 64 bits（最大可以到 $2^{64} - 1$）所以實務上不可能有相同的 entry ID。

### Basic Commands

- `XADD`：在指定 stream 中新增一個 entry。
- `XRANGE`：Query 某兩個時間點間的所有 entries。
- `XREAD`：訂閱 stream 並取得最新的 entries。
- `XLEN`：

>[!Note]
>關於 Redis Stream 的詳細介紹，請看[這篇](</Database/Redis/Redis Stream.draft.md>)。
