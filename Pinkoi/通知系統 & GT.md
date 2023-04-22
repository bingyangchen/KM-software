# 相關 Tasks

- https://app.asana.com/0/1201591574237600/1204191157675342/f

# 教學文件

- 通知系統 (Email, App Push, Notification Center)

    <https://sites.google.com/pinkoi.com/epd-wiki/dev-guide-tmp/be-%E9%80%9A%E7%9F%A5%E9%96%8B%E7%99%BC%E9%A0%88%E7%9F%A5>

- Guiding Tips

    <https://paper.dropbox.com/doc/Guiding-Tips-Admin-Tool---B2wmGo~M3CncImEXm56k33WDAg-wQwhd4F32n8DVeHkuan6X>

> [!Note]
> 通知系統 (Email, App Push, Notification Center) 分為新版與舊版，若有新的通知要發盡量用新版。

# 新版通知系統

### Repo 中的相關檔案

- `models2/notification/configs.py` 定義每一種不同的通知的 mata
- `models2/notificaiton/contexts.py` 定義通知中可填數哪些變數
- `models2/notification/service.py`

    - `NotificationServeice` funciton 負責發送通知的 Class，有發送通知的 method: `send`

### Email

#TODO 

### App Push

#TODO 

### Notification Center (NC)

#TODO 

# 舊版通知系統

### Repo 中的相關檔案

- `base/notification`

    `CONF` dictionary 用來定義通知

#TODO 

# 預覽 Email

#TODO 

# Guiding Tips

#TODO 
