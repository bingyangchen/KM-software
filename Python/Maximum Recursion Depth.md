Python 預設的 maximum recursion depth 為 1000 層

呼叫 `sys.getrecursionlimit()` 可以得到 maximum recursion depth:

```Python
import sys

print(sys.getrecursionlimit()) # 1000
```

`sys.setrecursionlimit()` 可以更改這個預設值：

```Python
import sys

print(sys.setrecursionlimit(2000))
```

**Consider this a dangerous action!**

## Recursion Error

當 recursive function 的遞迴深度超過限制時，會報錯：

e.g.

```Python
def fibonacci(n):
	if n <= 1:
		return n
	return(fibonacci(n-1) + fibonacci(n-2))

print(fibonacci(1000))
```

Output:

`RecursionError: maximum recursion depth exceeded while calling a Python object`

# 暫時更改 Recursion Depth Limit

>下方關於 `with` 的語法可參考 [[with]]

```Python
import sys

class recursion_depth:
	def __init__(self, limit):
		self.limit = limit
		self.default_limit = sys.getrecursionlimit()
	
	def __enter__(self):
		sys.setrecursionlimit(self.limit)
	
	def __exit__(self, type, value, traceback):
		sys.setrecursionlimit(self.default_limit)

with recursion_depth(2000):
	print(fibonacci(1000))
```

這個方法可以確保只有在 `with` block 內， recurision limit 才是指定的數量，脫離 `with` block 後，recurision 便會變回預設的 1000。