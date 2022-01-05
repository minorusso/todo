# README


# テーブル定義
|Task|
|------|
|title :string|
|details :text|

# Herokuへのデプロイ手順

### 環境
・Ruby3.0.1
・Rails6.0.3

1. Herokuにアプリケーションを作成する
```
$ heroku create
```
2. アセットプリコンパイルをする
```
$ rails assets:precompile RAILS_ENV=production
```
3. コミットする
```
$ git add -A
$ git commit -m "init"
```
4. Herokuにデプロイ実行
```
$ git push heroku master
```
5. データベースの移行
```
$ heroku run rails db:migrate
```
6. アプリケーションにアクセス(アプリ名を確認する)
```
($ heroku config)
$ heroku open
```
