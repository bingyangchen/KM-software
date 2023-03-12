# 什麼是 Nested Query

一個 query 語句的 `SELECT` 子句或 `WHERE` 子句中若含有另一個 query，這樣的結構就稱為 nested query，其中裡面的 query 稱為 subquery 或 inner query，外面的 query 則稱為 outer query：

```PostgreSQL
SELECT column_name [, column_name, ... ]
FROM table1 [, table2, ... ]
WHERE column_name <operator> (
    SELECT column_name [, column_name, ... ]
    FROM table1 [, table2, ... ]
    [WHERE <condition>]
)
```

除了 `SELECT` 以外，nested query 還可以被用在 `INSERT`, `UPDATE` 以及 `DELETE` 語句中，其作用皆是扮演「篩選條件」的角色。

# Nested Query 的使用規則

- Subquery 必須用 `()` 包覆之
- 出現在 `SELECT` clause 中的 subquery 必須是 [[#^546f7e|scalar subquery]]
- Subquery 中的 `SELECT` 子句中通常只會有一個 column，除非 outer query 的 `WHERE` 子句中有「拿多個 subquery output 的 columns 來進行比較」的動作（[[#^e6b41b|見此段]]），或者根本不在意有幾個 columns（比如使用 `EXISTS` 時）
- Subquery 中不能出現 `ORDER BY` 子句，但可以用 `GROUP BY` 來達到 `ORDER BY` 的效果
- Subquery 的 output 只有一個 row 時，outer query 只能用 `=`, `<`, `>`, `>=`, `<=`, `<>`, `<=>` 等 single-row operators 來進行比較運算
- Subquery 的 output 不只一個 row 時，outer query 只能用 `IN`, `EXISTS`, `NOT IN`, `ANY`, `ALL` 等 multi-row operators 來進行比較運算
- `BETWEEN` operator 不可以在 outer query 的 `WHERE` 子句中與 subquery 並用

### Subquery 與 `EXISTS` 並用時，常見的寫法

`EXISTS` 判斷的是 subquery 中是否含有任何 row，若有則 return true，否則 return false，由於 row 裡的 value 是什麼並不重要，因此常常只在 subquery 的 `SELECT` 子句中寫一個數字 1，不回傳任何實際的 column，像是下面這樣：

```PostgreSQL
SELECT ... FROM ...
WHERE EXISTS (
    SELECT 1 FROM tbl
    WHERE ...
);
```

當然，`SELECT 1` 只是大家常用的寫法，並不是硬性規定。

# Scalar Subquery

^546f7e

若 subquery 的 output 只有一個 row，且該 row 有只有一個 column，則其實該 output 就是一個 scalar，該 scalar 可以在 outer query 中使用 single-row operators 來做比較，舉例如下：

```PostgreSQL
SELECT employee_id, salary FROM employees
WHERE salary > (
    SELECT AVG(SALARY) FROM employees
);
```

Scalar subquery 也可以出現在 `SELECT` clause 中：

```PostgreSQL
SELECT name, (
    SELECT max(pop) FROM cities
    WHERE cities.state = states.name
)
FROM states;
```

# Row Subquery

^e6b41b

若 subquery 的 output 只有一個 row，且該 row 有不只一個 column，則稱該 subquery 為 row subquery，搭配 row subquery 所使用的比較運算子必須是 single-row operators，且 operator 的左手邊也必須是一個 `ROW`，舉例如下：

```PostgreSQL
SELECT first_name FROM employees
WHERE ROW(department_id, manager_id) = (
    SELECT department_id, manager_id FROM departments
    WHERE location_id = 1800
);
```

# 變數的 Refer

Subquery 裡可以 refer outer query 的變數 ，比如下例中的 `s`：

```PostgreSQL
SELECT * FROM student AS s
WHERE NOT EXISTS (
    SELECT sid FROM enrollment AS e
    WHERE e.cid = 1 AND e.sid = s.id
);
```

但在 outer query 中不可 refer subquery 中的變數。

# 執行效率

PostgreSQL 碰到 nested query 時，為了提高效率，只會執行 subquery 一次，將這個 result 暫存起來以利重複使用，再將 result 交給 outer query，最後才執行 outer query。

Nested query 相對於 single-layer 的 query 的效率是較低的，因此建議能用越少層的 Nested Query 選出相同資料，就用越少層。

關於 Nested Query 與 Single-layer Query 的執行效能，可以參考 [[IN vs. EXISTS vs. ANY, ALL vs. JOIN]] 這篇文章。

# 參考資料

<https://www.tutorialspoint.com/postgresql/postgresql_sub_queries.htm>

<https://www.w3resource.com/PostgreSQL/postgresql-subqueries.php>
