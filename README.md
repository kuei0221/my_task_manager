# README
### Version
* ruby: 2.7.2
* rails: 6.1.1
* postgresql: 13.1

### Deployment
部署步驟：
1. 註冊並登入heroku
2. 前往個人dashboard並建立新的app
3. 在新app的頁面裡選擇deploy分頁，選擇使用github作為部署的方法並連結到對應的repo
4. 在自動部署的區塊，啟用自動部署，和等ci通過才部署
5. 最後先手動部署一次檢查網頁狀態

以後只要推到master branch就會自動部署上heroku

### Database Draft (step 4)
![database draft](datebase_draft.jpg)