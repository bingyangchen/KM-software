# 顯示系統狀態

### 顯示系統核心資訊

```bash
uname -a
```

Example output:

```plaintext
Darwin MyMacbook 22.6.0 Darwin Kernel Version 22.6.0: Wed Jul  5 22:22:52 PDT 2023; root:xnu-8796.141.3~6/RELEASE_ARM64_T8103 arm64
```

### 顯示 CPU 與 Memory 資訊

```bash
cat /proc/cpuinfo  # for CPU
cat /proc/meminfo  # for memory
```

### 顯示磁碟剩餘空間

```bash
df -h
```

Example output:

```plaintext
Filesystem       Size   Used  Avail Capacity iused     ifree %iused  Mounted on
/dev/disk3s3s1  228Gi  8.5Gi   78Gi    10%  356050 814527160    0%   /
devfs           205Ki  205Ki    0Bi   100%     710         0  100%   /dev
/dev/disk3s6    228Gi  2.0Gi   78Gi     3%       2 814527160    0%   /System/Volumes/VM
/dev/disk3s4    228Gi  4.9Gi   78Gi     6%    1027 814527160    0%   /System/Volumes/Preboot
/dev/disk3s2    228Gi   85Mi   78Gi     1%      44 814527160    0%   /System/Volumes/Update
/dev/disk1s2    500Mi  6.0Mi  483Mi     2%       3   4942560    0%   /System/Volumes/xarts
/dev/disk1s1    500Mi  6.2Mi  483Mi     2%      33   4942560    0%   /System/Volumes/iSCPreboot
/dev/disk1s3    500Mi  396Ki  483Mi     1%      35   4942560    0%   /System/Volumes/Hardware
/dev/disk3s1    228Gi  134Gi   78Gi    64% 1959935 814527160    0%   /System/Volumes/Data
map auto_home     0Bi    0Bi    0Bi   100%       0         0  100%   /System/Volumes/Data/home
```

### 顯示記憶體與 Swap 區的用量

```bash
free
```

# 關機

Linux 的關機指令有 `shutdown`、`halt`、`poweroff` 三種：

### 一、`shutdown`

`shutdown` 相對於 `halt` 與 `poweroff` 而言，是比較安全也比較建議使用的關機方式：

```bash
shutdown [{OPTION}] {TIME} [{MESSAGE}]
```

常見的用法包括：

- 立即關機

    ```bash
    shutdown -h now
    ```

- 指定時間關機

    ```bash
    shutdown -h 21:30
    ```

- 取消關機

    ```bash
    shutdown -c
    ```

- 重新開機

    ```bash
    shutdown -r
    # has the same effect as
    reboot
    ```

**常用的 Options**

|Option|Description|
|:-:|:-:|
|`-r`|Reboot（重新開機）|
|`-H`|Halt（停止 CPU 運作，但電源仍然開著）|
|`-P`|Power off（關閉電腦電源）|
|`-h`|由系統決定要 halt 還是 power off|
|`-c`|取消前一個關機命令|
|`-k`|禁止其它 user 登入，並對已登入的 user 發出關機通知，但不實際關機|

### 二、`halt`

```bash
halt -f
```

與 `shutdown -H` 不同處在於，`halt -f` 不會管目前電腦的狀態為何，會直接將電腦停機。

### 三、`poweroff`

```bash
poweroff -f
```

與 `shutdown -H` 不同處在於，`poweroff -f` 不會管目前電腦的狀態為何，會直接將電腦的電源關掉。
