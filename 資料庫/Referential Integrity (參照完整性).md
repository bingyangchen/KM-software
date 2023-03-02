# 定義

---

Relational Database 中，若某個 relation R 的某欄位 C1 reference 另一個欄位 C2（同一個 relation 內的或不同 relation 的皆可），則除非 C1 的值為 null，否則都必須對應到「剛好一筆」在 C2 欄位具有相同值的資料。

在符合 Referential Integrity 的條件下，C1 就是 R1 的 Foreign Key，C2 則必須是其所屬之 relation 的 Primary Key 或 Candidate Key。

### On-Delete Action

On-Delete Action 指的是當 referenced data 要被刪除時，referencing data 的 Foreign Key 要做什麼動作。On-Delete Action 有以下四種：

- `CASCADE`
	
	將 reverencing data 連同 referenced data 一起刪除。

- `NO ACTION`
	
	不刪除 referenced data 也不刪除 referencing data。

- `SET NULL`
	
	將 reverencing data 的 Foreign Key 設為 `null`，然後將 referenced data 刪除。

- `SET DEFAULT`
	
	將 reverencing data 的 Foreign Key 設為預設值，然後將 referenced data 刪除。

# 參考資料

---

https://en.wikipedia.org/wiki/Referential_integrity