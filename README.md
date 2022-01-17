# README


# テーブル定義
### User
| ------------------ | ---------------- | -------- | 
| 名前               | name             | string   | 
| メール             | email            | string   | 
| パスワード         | password_digest  | string   |
| 管理者             | admin            | boolean  |

### Task
| ------------------ | ---------------- | -------- | 
| タスク名           | title            | string   | 
| タスク詳細         | details          | text     | 
| 終了期限           | time_limit        | datetime | 
| 優先度             | priority         | integer  | 
| ステータス         | completed         | integer  | 

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
3. Heroku buildpackを追加する
```
$ heroku buildpacks:set heroku/ruby
$ heroku buildpacks:add --index 1 heroku/nodejs
```
4. コミットする
```
$ git add -A
$ git commit -m "init"
```
5. Herokuにデプロイする
```
$ git push heroku master
```
6. データベースの移行
```
$ heroku run rails db:migrate
```
7. アプリケーションにアクセス(アプリ名を確認する)
```
($ heroku config)
$ heroku open
```
