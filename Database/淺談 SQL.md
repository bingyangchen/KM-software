# 分類

SQL 依照功能可以分為 DML、DDL 與 DCL：

### DML

^146eea

DML 是 Data "Manipulation" Language 的縮寫，包含 `SELECT`、`INSERT`、`DELETE` 與 `UPDATE` 等 commands（雖然其實 `SELECT` 與 manipulation 無關）。

### DDL

^08460a

D for "Definition"，也就是與定義 Database Schema 相關的 commands，如 `CREATE`、`ALTER`、`TRUNCATE` 與 `DROP` 等。

### DCL

C for "Control"，包含與 security, access control 相關的 commands，比如 `GRANT` 與 `REVOKE`。

# Aggregate Function

凡是經過運算一堆 tuples (rows) 後 output 一個 scalar 的 function，就叫做 Aggregate Function，簡稱 Aggregates。

詳見 [[Aggregate Functions]]。

# String

### 字串在不同 RDBMS 中的差別

| **RDBMS** | **字串比對 (column value)** | **引號** |
| ---- | ---- | ---- |
| PostgreSQL | 可以比對大小寫| 只能用單引號 |
| MySQL | ==無法==比對大小寫 | 單雙皆可 |

### 字串模糊比對 Operator：`LIKE`

**Wildcard: `%` & `_`**

字串模糊比對時，`%` 代表萬用字元（任意長度、任意字元），`_` 則代表長度為 1 的任意字元。

**e.g.**

```PostgreSQL
SELECT * FROM student AS s WHERE name LIKE 'K%';
```

### String Functions

常用的 String Functions 包括 `||` (串接)、`LOWER`、`UPPER`、`SUBSTRING`、`TRIM`... 等。String Functions 不屬於 Aggregate Function。

# 參考資料

- <https://www.youtube.com/watch?v=6VCHuLqfmV8&list=PLSE8ODhjZXjbohkNBWQs_otTrBTrjyohi&index=3>
