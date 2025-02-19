Homebrew 是 MacOS 上最常用的套件管理工具之一，常常會看到使用 `brew` 開頭在安裝一些套件，使用的就是 Homebrew。

# 安裝

### Step1: 使用 `curl` 安裝 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

如果你的 MacOS 中還沒有 `curl`，可以先[[Xcode CLT#安裝|安裝 Xcode]]，裡面會包含 `curl`。

### Step2: 將 Homebrew 加入 `PATH`

```bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zprofile
```

# 常用指令

### 確認 Homebrew 版本

```bash
brew --version
```

### 更新 Homebrew

```bash
brew update
```

### 更新所有用 Homebrew 安裝的套件到最新版本

```bash
brew upgrade
```
