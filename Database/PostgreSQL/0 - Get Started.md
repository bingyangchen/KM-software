# On MacOS

### Installation

```bash
brew install postgresql

# or, specify which version to install
brew install PostgreSQL@{VERSION}
```

- 沒有指定版本的話，Homebrew 預設會幫你下載 version 14

>[!Note]
>執行這個指令時，若出現 `command not found: brew`，代表你的電腦中沒有沒有 Homebrew，此時你須要先[[Homebrew#安裝|安裝 Homebrew]]。

### 在背景執行 PostgreSQL Server

```bash
brew services start postgresql

# or, speicify the version
brew services start postgresql@{VERSION}
```

### [[2 - psql#進入 psql|進入 PostgreSQL CLI]]

### 關閉背景執行的 PostgreSQL Server

```bash
brew services stop postgresql

# or, speicify the version
brew services stop postgresql@{VERSION}
```

# On Linux Ubuntu

### Installation

```bash
# Step1: Create the file repository configuration.
sudo sh -c 'echo "deb https://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

# Step2: Import the repository signing key.
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# Step3: Update the package lists.
sudo apt-get update

# Step4: Install the latest version of PostgreSQL.
sudo apt-get -y install postgresql
```

### 在背景啟動 Server

```bash
sudo systemctl start postgresql.service
```

### 查看狀態

```bash
sudo systemctl status postgresql.service
```

### 關閉背景運行的 Server

```bash
sudo systemctl stop postgresql.service
```

# 參考資料

- [官方網站](https://www.postgresql.org/download/linux/ubuntu/)
- [這個網站](https://adamtheautomator.com/install-postgresql-on-mac/)提供使用 installer 安裝以及使用 CLI 安裝的教學
