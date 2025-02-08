同一個 host 上的各個 containers 間預設不會影響彼此，也不能進行溝通，但在一個 multi-container application 中，containers 間勢必得溝通，比如 API server 須要跟 DBMS 拿資料。要讓 containers 間互相溝通就必須先在它們之間建立 **network**。

### Create Network

```bash
docker network create {NETWROK_NAME}
```
