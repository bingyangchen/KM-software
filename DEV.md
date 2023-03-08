# 如何更新

## 首次安裝

此專案有從 GitHub 連接至 GitBook，因此需要提供 `SUMMARY.md` 檔案，我透過 `gitbook-summay` 這個 npm package 將這個步驟自動化。

```sh
npm i
```

但因為這個套件所產生的 `SUMMARY.md` 在 hyperlink 上有 bug，尤其是當文件名稱內含有空格時。因此安裝完套件後必須手動修改套件內的程式碼：

- 更動一： `./node-modules/gitbook-summary/lib/summary/index.js`

    ```JavaScript
    // line 155 ~ line 158
    function formatCatalog(folderName, sign="-") {
        sign = sign;
        return sign + " [" + prettyCatalogName(folderName) + "](<";
    }
    ```

- 更動二： `./node-modules/gitbook-summary/lib/files.js`

    ```JavaScript
    // line 58 ~ line 60
    if (obj.ext === '.md') {
        filesJson[getFrontMatterTitle(newpath)] = newpath + ">)\n";
    }
    ```

## 後續維護

因為將新的版本推送至 GitHub 後就會觸發 GitBook 的更新，所以在推送前必須根據現在的文件結構更新 `SUMMARY.md` 並一起推送。

```sh
npx boook sm -t "Table of contents" -d
```

關於上方指令所用到的 options，詳情請參考 [官方文件](https://www.npmjs.com/package/gitbook-summary)。
