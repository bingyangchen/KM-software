根據[這篇文章](https://blog.diogomonica.com//2017/03/27/why-you-shouldnt-use-env-variables-for-secret-data/)的說法，把 sensitive data 存成環境變數是不安全的，因為環境變數可能意外地被印在系統的 error log 中，也可以被任何 process 讀取到，比較好的做法是使用 Docker Secret。

#TODO 
