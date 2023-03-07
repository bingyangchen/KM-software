### 旋轉 2D list

```Python
m = [[1, 2], [3, 4]]

# Clockwise rotation
l = list(zip(*m[::-1]))
print(l)  # [[3, 1], [4, 2]]

# Counterclockwise rotation
l = list(zip(*m)[::-1])
print(l)  # [[2, 4], [1, 3]]
```

---

### Flatten 2D list

```Python
m = [[1, 2], [3, 4]]
l = sum(m, [])
print(l)  # [1, 2, 3, 4]
```

---

### Tuple Unpacking

Tuple Unpacking 指的是將一個 tuple 中的各個值一次 assign 給多個變數，舉例而言：

```python
a, b, c = (1, 2, 3)

# 其實也可以不用寫 `(` 與 `)`
a, b, c = 1, 2, 3
```

「變數交換值」可以使用 Tuple Unpacking 來一行解決：

```python
a, b = b, a

# 在其他語言中，必須使用 temp 才能交換內容，所以至少會有三行
temp = a
a = b
b = temp
```

---

### List Comprehension

```python
l = [i ** 2 for i in range(10)]

# 上方程式碼可以取代下方程式碼

l = []
for i in range(10):
	l.append(i**2)
```

---

### Chained Assignment

```python
a = b = 10;

# 上方程式碼可以取代下方程式碼

a = 10
b = 10
```

當 assign 給各個變數的值的型態是基本資料型態時，各變數間不會連動，但若 assign 給各個變數的值是一個物件時，各變數間就會連動，比如說：

```python
i = j = 10
i = 0
print(i, j)  # 0, 10

a = b = [10]
a[0] = [0]
print(a, b)  # [0], [0]
```

---

### `enumerate`

使用 `enumerate` 同時獲取序列迭代的 index 和 value：

```python
l = ['a', 'b', 'c']
for idx, char in enumerate(l):
	print(idx, char)
# 0, 'a'
# 1, 'b'
# 2, 'c'
```

---

### 使用 `get` 處理 Dict 中找不到 key 的狀況

```python
aDict[k] = aDict.get(k, 0) + 1

# 上方程式碼可以取代下方程式碼

if k in aDict:
	aDict[k] += 1
else:
	aDict[k] = 1
```

---
- 充分利用 [[Lazy evaluation]] 的特性，從而避免不必要的計算

- 不推薦使用 `type` 來進行型別檢查，因為有些時候 `type` 的結果並不一定可靠。建議使用 `isinstance` 代替

- `eval` 容易有安全漏洞

- 習慣使用 [[with]] 自動關閉資源

- 盡量不要單獨使用 `except:` 或 `except Exception:`，而是定位到具體的例外名稱。

# 參考資料

https://allaboutdataanalysis.medium.com/%E7%B8%BD%E7%B5%90%E4%BA%8690%E6%A2%9D%E7%B0%A1%E5%96%AE%E5%AF%A6%E7%94%A8%E7%9A%84python%E7%A8%8B%E5%BC%8F%E8%A8%AD%E8%A8%88%E6%8A%80%E5%B7%A7-e6863f639bf6