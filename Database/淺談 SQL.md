# 分類

SQL 依照功能可以分為 DML、DDL 與 DCL：

### DML

DML 是 Data "Manipulation" Language 的縮寫，包含 `SELECT`、`INSERT`、`DELETE` 與 `UPDATE` 等 commands（雖然其實 `SELECT` 與 manipulation 無關）。

### DDL

D for "Definition"，也就是與定義 Database Schema 相關的 commands，如 `CREATE`、`ALTER`、`TRUNCATE` 與 `DROP` 等。

### DCL

C for "Control"，包含與 security, access control 相關的 commands，比如 `GRANT` 與 `REVOKE`。

# Aggregate Function

凡是經過運算一堆 tuples (rows) 後 output 一個 scalar 的 function，就叫做 Aggregate Function，簡稱 Aggregates。

詳見 [[Aggregate Functions]]。

# 參考資料

- <https://www.youtube.com/watch?v=6VCHuLqfmV8&list=PLSE8ODhjZXjbohkNBWQs_otTrBTrjyohi&index=3>
