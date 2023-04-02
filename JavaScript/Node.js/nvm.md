nvm 是 Node Version Manager 的縮寫，讓我們可以透過 CLI 在同一台電腦的全域環境中切換不同版本的 Node.js。

# 在 MacOS 上安裝 nvm

### Step1: 打開 terminal 使用 `curl` 安裝

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
```

### Step2: 重啟 terminal

透過以下指令檢查是否成功安裝 nvm：

```bash
command -v nvm
```

# 常用指令

### 安裝最新版本的 Node

```bash
nvm install node
```

### 安裝指定版本的 Node

範例：

```bash
nvm install 14.7.0
```

### 切換為某個指定版本的 Node（須先安裝）

範例：

```bash
nvm use 14.7.0
```

### 查看有哪些版本可以下載

```bash
nvm ls-remote
```

### 查看已經下載了哪些版本

```bash
nvm ls
```

# 參考資料

<https://github.com/nvm-sh/nvm>