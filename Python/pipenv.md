使用虛擬環境開發專案的好處主要有二：

1. 一個人維護多個專案時，各專案所需的環境不同，此時利用虛擬環境可以達到「隔離」的效果
2. 多個人維護一個專案時，須確保所有人的開發環境相同，並且希望新加入的人可以快速建置出相同的環境，此時虛擬環境的設定檔可達到「快速複製環境」的效果

所謂的「環境」包括：

1.  用來執行該專案的 Python 的版本
2.  專案所用到的第三方套件的版本
3. 與 2. 所相依的套件的版本

pipenv 是一個結合 virtual enviroment 及套件管理的開發工具，同時也是 pip 官方推薦的套件管理工具之一。

# 安裝 pipenv

建議使用系統內建的 pip 將 pipenv 全域安裝，這樣無論在什麼 directory 都可以使用 pipenv：

```bash
pip install pipenv
```

其實安裝 pipenv 的方法有很多，例如也可以使用 brew 或 apt-get，此處略。

### 確認 pipenv 版本

```bash
pipenv --version
```

# 為專案建置虛擬環境

### Step1: 建立

切換至專案根目錄後，輸入以下指令：

```bash
pipenv --python <version>
```

此時會發生兩件事：

1. 在目前的 directory 下產生一個名為 `Pipfile` 的檔案，以 toml 格式呈現：

	```toml
	[[source]]
	url = "[https://pypi.org/simple](https://pypi.org/simple)"
	verify_ssl = true
	name = "pypi"
	
	[packages]
	
	[dev-packages]
	
	[requires]
	python_version = "3.10"
	```

2. 在電腦中的某個**預設路徑**產生對應的虛擬環境資料夾，所有專案的虛擬環境資料夾都會在一個名為 `.virtualenvs` 或 `vertualenvs` 的資料夾底下。

	透過下方指令可以查詢**預設路徑**：

	```bash
	pipenv --venv
	```

須注意，由於要被安裝在虛擬環境內的 Python 是基於本機全域的 Python 所建立的，所以 `<version>` 必須跟全域安裝的那個 Python version 一樣。

然而，如果本機有安裝 [[pyenv]] 這個 package，則在建立虛擬環境的時候，若要求的 Python version 在目前主機上沒有，會自動提示要不要使用 pyenv 安裝。

### Step2: 安裝

在專案根目錄執行以下指令，安裝 Pipfile 中所指定版本的 Python 以及基本的套件：

```bash
pipenv install
```

完成後你會發現專案根目錄中多了一個叫做 `Pipfile.lock` 的檔案，`Pipfile` 與 `Pipfile.lock` 的差異如下：

-   `Pipfile` 內所描述的套件版本可以是模糊的。

-   `Pipfile.lock` 內的套件版本都會明確指定，並且會控制下載套件的來源、記錄套件的 dependencies，還會根據套件內容計算出 hash value 來防止惡意套件被載入。

# 啟動虛擬環境

啟動 pipenv 虛擬環境的方式，即使用 CLI 到該專案所屬的虛擬環境資料夾中的 `/bin` 資料夾中，執行 `activate` 這個檔案。如須啟動目前專案的虛擬環境，可以結合前面介紹的「查詢虛擬環境資料夾路徑」的指令來完成：

```bash
source $(pipenv --venv)/bin/activate
```

# 使用 pipenv 安裝套件

#TODO
