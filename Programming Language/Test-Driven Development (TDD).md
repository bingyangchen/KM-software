# TDD 的三大法則

- 第一法則：在撰寫第一個單元測試前，不撰寫任何 production code
    - 這個測試會因為 production code 還沒寫而出現 compile error
- 第二法則：當有一個測試因為第一法則而出現 compile error 時，就不要再寫其它新的測試，此時應該去補上造成 compile error 的 production code
- 第三法則：只撰寫剛好能通過當前所有測試的 production code

測試應該要可以在任何環境中重複執行。

# AAA Pattern

Arrange, Act, Assert

**Example**

#TODO 

### 參考資料

- <https://medium.com/@pjbgf/title-testing-code-ocd-and-the-aaa-pattern-df453975ab80>

# Testing Pyramid

|![](<https://raw.githubusercontent.com/bingyangchen/KM-software/master/img/testing-pyramid.png>)|![](<https://raw.githubusercontent.com/bingyangchen/KM-software/master/img/testing-pyramid-2.png>)|
|-|-|

#TODO 
