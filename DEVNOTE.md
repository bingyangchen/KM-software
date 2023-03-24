# 如何維護此專案

## 編譯 SCSS

本專案採用 SCSS 編輯 Obsidian 編輯器的外觀，也就是說原則上開發者只會透過手動更改 `.scss` 檔案來更改外觀，且必須使用第三方套件將其編譯為 `.css` 檔，指令如下：

```bash
# 在根目錄執行
npx sass ./.obsidian/snippets/custom.scss ./.obsidian/snippets/custom.css --no-source-map
```

---

## 準備 `SUMMARY.md` 檔

因為將新的版本推送至 GitHub 後就會觸發 GitBook 的更新，所以在推送前必須根據現在的文件結構更新 `SUMMARY.md` 並一起推送，指令如下

```bash
sh summary.sh
```
