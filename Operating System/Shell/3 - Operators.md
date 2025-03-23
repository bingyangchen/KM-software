# Piping

>[!Note]
>在了解 piping 之前，你會須要先了解 [[Operating System/Shell/1 - Introduction#STDIN, STDOUT & STDERR|stdin, stdout & stderr]]。

```bash
{COMMAND_A} | {COMMAND_B}
```

`|` 稱為 pipe，用來連接兩個指令。會先執行左側指令，並將左側指令的 stdout 作為右側指令的 stdin，然後執行右側指令。

e.g.

```bash
echo "hello world" | grep "h"
# hello world
```

# Output Redirection

```bash
{COMMAND} > {FILENAME}
```

`>` 會將左側 `{COMMAND}` 的 stdout 導向（寫入）右側的 `{FILE}`。

e.g.

```bash
echo hello > myfile.txt
```

以上例而言，若直接執行 `echo hello`，Shell 會將 hello 印在 terminal 上；加上 `>` 後，hello 會被導向並寫入 myfile.txt 這個檔案，所以此時 terminal 不會印出文字。

### Append Mode

若 redirect output 時不想要將檔案內容覆蓋，而是想將 stdout 加在原檔案內容的後面，則應使用 `>>` 取代 `>`：

```bash
touch myfile.txt

echo hello > myfile.txt
echo world >> myfile.txt

cat myfile.txt
# hello
# world
```

### 將 stdout 導向 stderr

使用 `>&` 搭配 [[Operating System/File System#File Descriptors (FD)|file descriptor]] 可以將 stdout 導向 stderr，比如：

```bash
echo hello 1>&2
```

也可以反過來將 stderr 導向 stdout，比如：

```bash
cat non-existing-file 2>&1 | tee -a test.txt
```

在上例中，如果只寫 `cat non-existing-file | tee -a test.txt`，在「`cat` 因找不到 non-existing-file 而 stderr」後，就不會繼續執行後面 `| tee -a test.txt` 的部分了。但若有 `2>&1`，Shell 就會將 `cat` 的 stderr (`cat: non-existing-file: No such file or directory`) 寫入 test.txt 中。

### 將 stderr 導向「黑洞」

```bash
{COMMAND} 2> /dev/null
```

- /dev/null 是一個檔案，任何寫入這個檔案的東西都會直接消失
- `2> /dev/null` 的意思是只將 stderr 導向 /dev/null，stdout 仍然會印在 terminal 上

# Input Redirection

```bash
{COMMAND} < {FILE}
```

`<` 會把右側 `{FILE}` 的內容讀入 stdin，並把 stdin 導向左側的 `{COMMAND}`。

e.g.

```bash
pbcopy < myfile.txt
```

`{COMMAND} < {FILE}` 的效果與 `cat` + piping (`cat {FILE} | {COMMAND}`) 是一樣的，唯一的差別是後者多一個尋找並執行 `cat` 的時間，所以使用 input redirection 通常會比較有效率。但若 `{COMMAND}` 是一個不接收 file input 的指令，那就還是得使用 `cat` + piping。

# Process Substitution

```bash
{COMMAND_A} <({COMMAND_B})
```

前面介紹的 input redirection 可以將 file 傳遞給 command，而這裡的 process substitution 是把一個 command 的 output 當作檔案，然後傳遞給另一個 command。

你可能會想，更前面介紹的 Piping 不就是在做這件事嗎？確實，不過兩者還是有一些細微的差異，下表是 Piping (`{COMMAND_A} | {COMMAND_B}`) 與 Process Substitution (`{COMMAND_A} <({COMMAND_B})`) 的差異：

| | Piping | Process Substitution |
|---|---|---|
|**Execution**|Both commands run ==concurrently==, ==streaming data==.|`{COMMAND_B}` runs in the ==background==, `{COMMAND_A}` reads from a ==pseudo-file==.|
|**Data Flow**|Directly from stdout to stdin.|`{COMMAND_B}`'s output is treated as a file.|
|**Efficiency**|More efficient for large data (streaming).|Can be slower if `{COMMAND_A}` expects file input instead of streaming.|
|**Use Case**|When `{COMMAND_B}` works with streamed input.|When `{COMMAND_A}` needs a **filename** as an argument (e.g., `diff`, `cmp`).|

>[!Note]
>`sh` 不支援 process substitution。

# 把指令丟到背景執行 - `&`

如果一個指令在執行時會佔用 process 一段時間，但你不想讓 terminal 因此一直被佔用著，那可以在指令後方加上 `&` 來把指令丟到背景執行：

```bash
{COMMAND} &
```

將指令丟到背景執行的好處就是 user 可以持續擁有 terminal 的控制權。

### 把背景的指令拉回前景

可以用 `fg` 將在背景運行的 job 拉回前景，前提是 ==user 必須仍然在當初使用 `&` 的那個 Shell session 中==：

```bash
fg [%{JOB_ID}]
```

如果當前的 Shell session 的背景中只有一個 job 則可以不用寫 `{JOB_ID}`，可以用 `jobs` 指令查看所有「當前 Shell session 中」的 jobs 以及它們的 job ID。

>[!Note]
>想知道更多關於 `fg`、`jobs` 指令以及 job control 的詳細介紹，可以看[[Job Control|這篇]]。

# Chaining Commands

### 有條件地接連執行指令 - `&&`

若將若干個指令用 `&&` 串連，則這些指令會「一個接著一個」被執行，只有前面的指令成功執行完畢才會執行後面的，否則就中斷。

e.g.

```bash
echo "hello" && echo "world"
# hello
# world
```

這麼做的效果等同於在 Shell script 中使用 `set -e` 讓 script 在遇到錯誤時就終止：

```bash
set -e
echo "hello"
# some other scripts
echo "world"
```

>[!Note]
>`&&` 也是條件式中的 AND operator。

### 有條件地接連執行指令 - `||`

只有 `||` 前面的指令執行失敗時（產生一個非 0 的 [[Operating System/Shell/1 - Introduction#Exit Codes|exit code]]），才會執行 `||` 後面的指令。

e.g.

```bash
echo "hello" || echo "world"
# hello
```

因為有成功執行 `echo "hello"`，所以就不執行 `echo "world"`。

>[!Note]
>`||` 也是條件式中的 OR operator。

### 無條件地接連執行指令 - `;`

無論前方的指令發生什麼事，都會從頭到尾執行所有指令。

e.g.

```bash
echo "hello"; echo "world"
# hello
# world

false; echo "hi"
# hi

# keep listening incoming TCP packages on port 8000 
while true; do nc -l localhost 8000; done
```

其實使用 `;` 的效果就和「不在開頭寫 `set -e` 的前提下」一行一行寫是一樣的，所以可以把 `;` 當作換行符號。

# 參考資料

- <https://thoughtbot.com/blog/input-output-redirection-in-the-shell>
