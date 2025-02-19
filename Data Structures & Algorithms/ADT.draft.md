資料結構 (data structure) 與 ADT (abstract data type) 的差異在於，ADT 對於資料的存取方式只做抽象描述，而資料結構是實際 implement ADT 後的結果。

常見的 ADT 包括：

### List

### Stack

### Queue

### Priority Queue

Heap 是常被用來實作 priority queue 的資料結構。

### Deque

Deque 就是在頭、尾都可以用 $O(1)$ 的時間複雜度進行 push 與 pop 的 queue。下表為 queue 與 deque 在不同操作下的時間複雜度：

| |Queue|Deque|
|:-:|:-:|:-:|
|**Push tail**|$O(1)$|$O(1)$|
|**Pop tail**|$O(1)$|$O(1)$|
|**Push head**|$O(n)$|$O(1)$|
|**Pop head**|$O(n)$|$O(1)$|

### Map
