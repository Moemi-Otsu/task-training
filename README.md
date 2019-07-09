# README

## Deploy
### herokuへのデプロイ手順
* $ rails assets:precompile RAILS_ENV=production
アプリのディレクトリ上で、上記のアセットプリコンパイルコマンドを実行します。

* config/environments/production.rb
config.assets.compile = false
上記記述をtrueに書き換えます。こうすることで本番環境上でアセットパイプラインを自動で通るようになります。

* git add -A
* git commit -m "prefix: メッセージ"
addとcommitをしておきます。

* git push heroku master
herokuへのpushコマンドを入力して実行します。

* heroku run rails db:migrate
Herokuデータベースの作成は自動で行われますが、マイグレーション（テーブル作成）は手動で実行する必要があります。

* herokuのURLへアクセスし、アプリケーションが問題なく動いているか確認します。

* heroku logs -t
herokuへのデプロイがうまくいっていなかったら、このコマンドでログを確認し、エラーを潰してください。

## Version
Ruby: ruby 2.6.3
Rails: Rails 5.2.3
PostgreSQL: 11.3

##  Table Users
* id　:integer
* user_name　:string
* email　:string
* password　:string

##  Table Tasks
* id　:integer
* user_id(FK)　:integer
* task_title :string
* task_content　:text
* deadline　:datetime
* priority　:string

##  Table Labels
* id　:integer
* task_id(FK)　:integer
* label_name :string

## Table Admin ???
