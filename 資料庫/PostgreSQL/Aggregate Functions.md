凡是經過運算一堆 rows 後 output 一個 scalar 的 function，就叫做 Aggregate Function。

PostgreSQL 中的 aggregate functions 包括：

- `avg()`
- `count()`
- `max()`
- `min()`
- `sum()`

# Aggregate Functions 與 `GROUP BY` 是好朋友

當 Aggregate Functions 與「其他非 Aggregate Function 的欄位」共同出現在 `SELECT` 子句中時，「其他非 Aggregate Function 的欄位」扮演的角色為「分組依據」，必須要有 `GROUP BY` 子句來說明如何用這些「其他非 Aggregate Function 的欄位」來做分組。

比如：

```PostgreSQL
SELECT max(score), cid FROM enrollment
GROUP BY cid;
```

的意思就是要「以班為單位，選出成績最高者」，注意，`GROUP BY cid` 是不能省略的。

由於上述限制，因此若我們想將 `max(score)` 當作一個 column 加在 `enrollment` 的後面，就不能用像是 `SELECT *, max(score) FROM enrollment;` 這樣的方式。那該怎麼做呢？其實有兩種方法可以做到：

**法一：`JOIN`**

```PostgreSQL
SELECT e.*, sub.max_score FROM enrollment AS e
JOIN (
	SELECT max(score) AS max_score, cid FROM enrollment
	GROUP BY cid
) AS sub
ON e.cid = sub.cid;
```

既然不能任意把其他 columns 寫在有 aggregate funciton 的 `SELECT` clause，那就使用 `JOIN` 將這些想加入的 columns 加進去。

**法二：`OVER`**

```PostgreSQL
SELECT *, max(score) over (partition by cid) FROM enrollment;
```

這個做法實際上是將 `max` 這個 aggregate function 轉化成 [[Window Functions|window function]]，可已發現無論是語法的簡潔度還是執行效率，這個方法皆勝出。

# Aggregate Functions 只能出現在 `SELECT` 及 `HAVING` 子句

舉例而言：

```PostgreSQL
SELECT sum(quantity) AS q_sum, sid
FROM trade_record GROUP BY sid
HAVING sum(quantity) > 0;
```

上例中，`HAVING` 不能以 `WHERE` 取代，因為 aggregation function 的執行順位在 `WHERE` clause 之後。

`HAVING` clause 中也不能使用 `SELECT` clause 中定義的變數 `q_sum`。

但是如果 aggregate functions 出現在 subquery 中，則該 subquery 還是可以正常地出現在 outer query 的 `WHERE` clause 中：

```PostgreSQL
SELECT * FROM cars
WHERE price = (
	SELECT max(price) FROM cars
);
```

# 參考資料

<https://www.postgresqltutorial.com/postgresql-aggregate-functions/>
