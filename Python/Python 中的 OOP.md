#OOP

# Python 中的 Encapsulation

### "類" Private attribute/method

^a80ae0

e.g.

```Python
class Human:
    def __init__(self):
        self.__max_age = 100

h = Human()
print(h.__max_age)
```

Output:

```plaintext
AttributeError: 'Human' object has no attribute '__max_age'
```

由上方的 error message 可知上例中的 `__max_age` 無法從 class 外部透過 `物件.__max_age` 的方式存取（只能在 class 內以 `self.__max_age` 的方式來存取），這是 Python 為了符合 OOP 中 [[OOP 四本柱#^5ba7b6|Encapsulation]] 這個性質所採取的做法。

為什麼說是 "類" private 呢？這是因為其實是有方法可以在 class 外取得這些以雙底線命名的 attribute 以及 method 的：

```Python
# 承接上面 Human class 的例子
h = Human()
print(h._Human__max_age)  # 100
```

>其實，Python 中並沒有真正的 encapsulation。

首先，Python 中完全沒有其它 OOP 語言中 **protect** 這個概念（社群上只有「用 `_` 作為 attribute/method 開頭」這種傳統／建議／風格）。

至於 **private** 呢，如同我們前面所見，是有方法可以繞過去的。這是因為其實 Python 是透過 **"Name Mangling"**（白話文就是「改個名字」）來達到「無法在 class 外直接 access 以 `__` 開頭的 attribute/method 」的效果，但只要我們知道名字被改成什麼，就可以 access 了。

>其實 Name Mangling 的初衷只是為了在 inheriting 時不要出現 naming conflicts。

# Python 中的 Inheritence

#TODO 
