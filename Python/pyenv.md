# 在 Mac 上安裝 pyenv

### Step1: 先確認 Mac 上有 homebrew

**1-1: 確認 homebrew 版本**

```bash
brew --version
```

若出現 `zsh: command not found: brew` 代表你的點腦中沒有沒有 homebrew，此時你需要安裝 homebrew：

**1-2: 安裝 homebrew 的 dependencies**

```bash
xcode-select --install
```

**1-3: 安裝 homebrew**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

**1-4: 將 homebrew 加入 PATH**

```bash
echo "export PATH=/opt/homebrew/bin:$PATH" >> ~/.zshrc
```

### Step2: 安裝 pyenv

```bash
brew install pyenv
```

# 使用 pyenv 安裝 Python

假設我現在要下載 Python 3.11.2：

```bash
pyenv install 3.11.2
```

# 其他常用指令

### 查看本機目前有哪些版本的 Python

```bash
pyenv versions
```

Output 會長的像下面這樣：

```plaintext
* system
  3.11.2 (set by /Users/pinkoi/.pyenv/version)
```

打星號的代表本機 Global 目前所使用的版本。

### 更改本機 Global 使用的 Python 版本

假設我要讓本機使用剛安裝好的 Python 3.11.2：

```bash
pyenv global 3.11.2
```

# 參考資料

<https://www.newline.co/courses/create-a-serverless-slackbot-with-aws-lambda-and-python/installing-python-3-and-pyenv-on-macos-windows-and-linux>
