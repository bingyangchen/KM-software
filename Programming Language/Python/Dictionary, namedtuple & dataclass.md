# Dictionary

當有一種物件具有多個 attributes，但又只是單純的資料，沒有「行為」時，通常不須要使用到 `class` 並建立 instance，可以簡單建立一個 dictionary 就好。舉例來說，一杯飲料有品名、甜度、冰塊，我們可以這樣定義：

```Python
black_tea = {
    "product_name": "Black Tea",
    "sugar": "sugar free",
    "ice": "regular",
}

print(black_tea["ice"])  # regular
```

這種做法簡單明瞭，但有兩個隱憂：

- **缺乏定義**

    當別人要建立另一杯飲料時，他只能透過觀察已經存在的其它飲料，來判斷一杯完整的飲料應該具備哪些 attributes。

- **無法有效防止 KeyError**

    使用 `d[key]` 的方式存取 dictionary 時，若 `key` 不存在於 `d` 中，則會在 run time 發生 KeyError。這無法透過 linter 事先檢查出來，因為 dictionary 是 mutable object，一個 key 一開始不存在於一個 dictionary 中，並不代表它永遠都不可能出現在這個 dictionary 中。

# namedtuple

Python 內建的 `namedtuple` 恰好可以解決上述 dictionary 的兩個隱憂：

```Python
from collections import namedtuple

Drink = namedtuple("Drink", ["product_name", "sugar", "ice"])

black_tea = Drink(
    product_name="Black Tea", sugar="sugar free", ice="regular"
)

print(black_tea.ice)  # regular
```

- 透過 `Drink = namedtuple("Drink", ["product_name", "sugar", "ice"])` 可以清楚知道一杯飲料應該具備 product_name, ice 與 sugar 三個 attributes
- namedtuple 是 immutable object，所以當不小心存取了不存在的 attribute 時，linter 可以幫我們檢查出來
- namedtuple 不像 tuple 要使用 index 取值，取而代之的是使用者自定義的 attribute name，具備與 dictionary 同等的可讀性

關於 namedtuple 的詳細使用方式，請見[官方文件](https://docs.python.org/zh-tw/3/library/collections.html#collections.namedtuple)。

然而，namedtuple 也不是完美的，由於 namedtuple 本質上還是 tuple，所以當使用 `==` operator 比較兩個 namedtuples 時，只會比較 tuple 中的各個元素，不會比較它們的 names，所以會出現下面這種狀況：

```Python
from collections import namedtuple

Drink = namedtuple("Drink", ["product_name", "sugar", "ice"])
Person = namedtuple("Person", ["drink", "mantra", "bmi"])

a = Drink("Black Tea", "sugar free", "regular")
b = Person("Black Tea", "sugar free", "regular")

print(a == b)  # True
```

其中一種解決上面這種尷尬狀況的方法是在建立 nametuple instance 時寫清楚參數名字：

```Python
# ...

a = Drink(
    product_name="Black Tea", sugar="sugar free", ice="regular"
)
b = Person(
    drink="Black Tea", mantra="sugar free", bmi="regular"
)

print(a == b)  # False
```

另外一個解決方式就是使用另一個 Python 內建的物件：`dataclass`。

# dataclass

Python 內建的 `dataclass` 透過 [Decorator](</Programming Language/Python/Decorator.md>) 裝飾 class，使得定義一個純資料的 class 時可以省略一些多餘的程式碼，示範如下：

```Python
from dataclasses import dataclass
from typing import Literal

@dataclass
class Drink:
    produt_name: str
    sugar: Literal["sugar free", "half sugar", "full sugar"]
    ice: Literal["ice free", "less ice", "regular"] = "regular"

c = Drink("Black Tea", "sugar free", "regular")
d = Drink("Green Tea", "full sugar")

```

dataclass 相對於 namedtuple 的優點如下：

- dataclass 搭配 [Type Hints](</Programming Language/Python/Type Hints.md>)，可以清楚定義各個 attributes 的型別
- dataclass 可以為 attribute 設定預設值

dataclass 與一般 class 的差別包括：

- 一般 class 需要定義 `__init__` method，dataclass 不用
- 使用 `==` 比較兩個 dataclass 的 instances 時，只會比較每個 attribute 的值是否相同，若都相同就會回傳 `True`；但使用 `==` 比較一般 class 的 instances 時，即使兩個 instances 的所有 attribute 的值都相同，還是會回傳 `False`

```Python
from dataclasses import dataclass
from typing import Literal


@dataclass
class Drink:
    produt_name: str
    sugar: Literal["sugar free", "half sugar", "full sugar"]
    ice: Literal["ice free", "less ice", "regular"] = "regular"

a = Drink("Black Tea", "sugar free", "regular")
b = Drink("Black Tea", "sugar free", "regular")
print(a == b)  # True

class Drink2:
    def __init__(
        self,
        produt_name: str,
        sugar: Literal["sugar free", "half sugar", "full sugar"],
        ice: Literal["ice free", "less ice", "regular"] = "regular",
    ):
        produt_name = produt_name
        sugar = sugar
        ice = ice

c = Drink2("Black Tea", "sugar free", "regular")
d = Drink2("Black Tea", "sugar free", "regular")
print(c == d)  # False
```

由於被裝飾的 class 本質還是 class，所以可以像一般的 class 一樣定義 method：

```Python
from dataclasses import dataclass

@dataclass
class TradeRecord:
    price: float
    quantity: int

    @property
    def total(self) -> float:
        return self.price * self.quantity

    def double_price(self) -> None:
        self.price *= 2
```

# 參考資料

- <https://docs.python.org/3/library/collections.html#collections.namedtuple>
- <https://docs.python.org/3/library/dataclasses.html>
- <https://realpython.com/python-data-classes/>
