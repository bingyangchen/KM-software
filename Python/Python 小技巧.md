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

- 變數交換值時使用 `a, b = b, a`，能不用 `temp` 就不用

- 充分利用 [[Lazy evaluation]] 的特性，從而避免不必要的計算

- 不推薦使用 `type` 來進行型別檢查，因為有些時候 `type` 的結果並不一定可靠。建議使用 `isinstance` 代替

- 警惕 `eval` 的安全漏洞

- 使用 `enumerate` 同時獲取序列迭代的 index 和 value

- 習慣使用 [[with]] 自動關閉資源

- 盡量不要單獨使用 `except:` 或 `except Exception:`，而是定位到具體的例外名稱。

# 參考資料

https://allaboutdataanalysis.medium.com/%E7%B8%BD%E7%B5%90%E4%BA%8690%E6%A2%9D%E7%B0%A1%E5%96%AE%E5%AF%A6%E7%94%A8%E7%9A%84python%E7%A8%8B%E5%BC%8F%E8%A8%AD%E8%A8%88%E6%8A%80%E5%B7%A7-e6863f639bf6