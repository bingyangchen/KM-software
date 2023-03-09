當我們安裝 npm 5.2 以上的版本時，npx 也會隨之被安裝。

### 不用全域安裝 (`-g`) 第三方 npm 套件，也能使用套件的指令

通常我們會希望第三方套件不要污染到電腦的 global Node.js environment，所以只安裝到 local environment，但這樣一來就不能「直接」在 terminal 使用第三方套件的指令（會出現類似 `zsh: command not found: <npm-package-command>` 的錯誤提示）這個問題可以使用 npx 解決：

```bash
npx <package-name> <package-command> [args...]

# Or to be precise:
npx --package=<package-name> -c '<package-command> [args...]'
```

# 參考資料

<https://medium.com/itsems-frontend/whats-npx-e83400efe7f8>

<https://docs.npmjs.com/cli/v9/commands/npx>
