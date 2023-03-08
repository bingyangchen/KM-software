若型別 $S$ 為型別 $T$ 的 subtype（型別 $T$ 為型別 $S$ 的 supertype），則可記做 $S<:T$ 或 $S \subseteq T$ 或 $S \leq: T$。

型別 $S$ 要能成為為型別 $T$ 的 subtype，其條件為：

>在可運行的函式（或程式碼片段）中，將任何型別為 $T$ 的物件替換成型別為 $S$ 的物件後，函式／程式碼片段應該仍然可以正常運行。

上面這個條件其實就是 [[Liskov Substitution Principle (LSP)]] 的核心宗旨。

一個簡單的實例就是 `Integer` 與 `Float` 之間的關係：在大多數程式語言中，任何可以接受 `Float` 的地方你都可以放入一個 `Integer`，所以可以說 `Integer` $<:$ `Float`。也有一些程式語言會額外定義 `Number` 這種 type，使得 `Integer` $<:$ `Number` $\wedge$ `Float` $<:$ `Number`（在這種情況下 `Integer` 與 `Float` 間就沒有 subtype 的關係了）

# Subtype vs. Subclass

你可能會覺得 subtype 就是 OOP 中的 subclass，但其實 subtyping 與 OOP 中的 classes [[繼承 (Inheritance)]] 是兩個分開的概念，而且兩個概念具有 orthogonality（正交性），也就是說 **沒有對應關係**。==Subtyping 是「兩個型別之間的關係」；Class inheritance 則是「實作時的重複利用」行為。==

當然在很多例子中，當 class A inherits from class B 時，class A 的型別恰巧會是 class B 的型別的 subtype，但是也有反例，現在我將以資料結構中 deque, queue 與 stack 間的關係來舉一個反例：

Queue 支援 `enqueue` 與 `dequeue` 兩個 methods，剛好對應到 deque 的 `insert_rear` 與 `delete_front` methods，所以 queue 可以 inherits from deque，這樣一來就不用重複實作相同的功能；stack 支援 `push` 與 `pop` 兩個 methods，分別對應到 deque 的 `insert_front` 與 `delete_front` methods，因此也可以 inherits from deque，由此可見，queue 與 stack 皆為 deque 的 subclass。但是根據 [[Liskov Substitution Principle (LSP)]]，queue 與 stack 皆不是 deque 的 subtype，因為若將 deque 替換成 queue，那麼在原本呼叫 `delete_front` 的地方就會出錯；同樣地，若將 deque 替換成 stack，那麼在原本呼叫 `insert_rear` 的地方就會出錯；反而是 queue 與 stack 都可以替換成 deque，因此 deque 是 queue 的 subtype，也是 stack 的 subtype。

Subtyping 對應到 OOP 的概念應該是「interfaces 間的 inheritance」以及[[多型 (Polymorphism)]]。

# 參考資料

<https://en.wikipedia.org/wiki/Subtyping#Function_types>

<https://www.cmi.ac.in/~madhavan/courses/pl2009/lecturenotes/lecture-notes/node28.html>
