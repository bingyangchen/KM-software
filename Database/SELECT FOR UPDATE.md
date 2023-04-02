使用 `SELECT ... FOR UPDATE` 的時機，是當你需要「先撈出資料，花一點時間處理，然後才更新資料」時，==其目的是避免 [[Concurrency#^fc28ed|Concurrency Anomaly]]==。

#TODO 

# 參考資料

- <https://www.cockroachlabs.com/blog/select-for-update/>
