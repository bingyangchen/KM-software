# 安裝

^afeaf9

### Step1: 安裝 Xcode

Xcode 是在 MacOS 上開發軟體時一定會用到的 IDE。

```bash
xcode-select --install
```

### Step2: 使用 curl 安裝 Homebrew

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Step3: 將 Homebrew 加入 PATH

```bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zprofile
```

# 常用指令

### `brew --version`

確認 Homebrew 版本。

### `brew update`

更新 Homebrew。
