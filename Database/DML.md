# `SELECT`

### Keyword Order

```PostgreSQL
SELECT … (欄位) [required]

OVER (PARTITION BY … (欄位)) [optional]

FROM … (表) [optional]

JOIN … (表) ON … (條件) [optional]

WHERE … (條件) [optional]

GROUP BY … (欄位) [optional]

ORDER BY … (欄位) ASC | DESC [optional]

LIMIT … (數字) OFFSET … (數字) [optional]

HAVING … (條件) [optional]
```

### 使用 `ORDER BY` 排序

^26d599

- 可以遞增 (`ASC`) 或遞減 (`DESC`)
- 可以設定多順位

e.g. `ORDER BY grade DESC, sid ASC`

### 使用 `LIMIT` 限制數量

- 通常要搭配 `ORDER BY` 出現
- 可以指定起始位置 (`OFFSET`)
- 可以用來實現 [[Pagination (分頁)#Offset Pagination|Pagination]]

e.g. `LIMIT 10 OFFSET 20`

# `INSERT`

#TODO 

# `UPDATE`

```PostgreSQL
UPDATE … (表) [required]

SET
    (欄位) = (值) [required]
    (欄位) = (值)
    …

WHERE … (條件) [optional]
```

# `DELETE`

#TODO 
