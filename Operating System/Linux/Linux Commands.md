### `which [<OPTIONS>] <FILE_NAME>`

顯示指定執行檔的所在的位置。

e.g.

```bash
which python
```

- 若有多個符合的結果則預設顯示第一個，若要顯示全部則需加上 `-a` option
- 由於回傳的結果不只是該執行檔所在的 directory，而是該執行檔，因此可以搭配 `eval $(...)` 來直接執行該執行檔

    e.g.

    ```bash
    eval $(which python)
    ```

---
