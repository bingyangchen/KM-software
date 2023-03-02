在 Python 程式碼中，我們有時候會看到在一個 module 的（通常是）最後面，會突然出現一個以 `if __name__ == "__main__":` 開頭的 block，這行程式代表什麼意思呢？

# Module Name

Python 中的 module 都有 `__name__` 這個 attribute，當位在該 module 內部時，任何 module 的 `__name__` 皆預設為 `"__main__"`，而當從 `module_a.py` 中 `import module_b` 時，`module_b.__name__` 就會是 `"module_b"`，也就是檔名。

所以說，在 module 內部寫 `if __name__ == "__main__":` 的用意就是，存在這個 block 內的程式碼只有在「直接運行這個 module」時會執行，若從其他 module import 這個 module 就不會執行這個 block 內的程式。

利用上述特性，這個 block 可以拿來寫 module 內部的 unit test。