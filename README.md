# アプリ名
## Picbook

# 概要
・ユーザー自身が読んだ絵本を画像、あらすじ、感想を入力して、投稿できるアプリケーション

# 本番環境(デプロイ先　テストアカウント＆ID)

・https://picbook.site

## ログイン情報（テスト用）
・ユーザー名：test

・Eメール：test@test


# 制作背景(意図)						
このアプリはお子さんのいる親御さんがより良い絵本に出会えるように作成しました。
例えば、書店で絵本を購入する際、世間的に認知された人気の作品以外は実際に購入してみないと結末はわからないと思います。すると、せっかく買ったのに想像していたものと違うということも考えられます。しかし、このアプリケーションは実際に絵本の投稿者の方達がそれぞれこういったストーリーでこんなふうに感じたと投稿することでそれを見たユーザーは多くの意見を取り入れ、実際にストーリーの全体像を掴むことができます。ストーリーが最初からわかっていたら面白味がないと感じる方もいらっしゃるかもしれませんが、あくまで親御さんはお子さんに楽しんでもらうことが目的なので、親御さんが求めるものはその絵本が果たして面白いものかということだと考えました。以上のことから親御さん方は絵本選びにあまり時間をかけずに面白い絵本に出会えるということがこのアプリケーションの最大の利点です。


# DEMO(gifで動画や写真を貼って、ビューのイメージを掴んでもらいます)						
⇒特に、デプロイがまだできていない場合はDEMOをつけることで見た目を企業側に伝えることができます。

## ・投稿一覧ページ
![Animated GIF-downsized_large](https://user-images.githubusercontent.com/76659162/108954048-85bc5a00-76af-11eb-8bff-305bbf7007d0.gif)

・投稿に対し、いいねでリアクション可能。

・投稿者は自身の投稿に対しては、編集、削除が可能。

・ページネーション機能により、投稿が一定数を超えると次ページに遷移できる。

## ・ユーザーマイページ
![](https://i.gyazo.com/edf9630b4af6517fd09669de473b1706.jpg)

・投稿一覧ページの機能と同じ

## ・投稿詳細ページ
![](https://i.gyazo.com/d54a0dd1cbc1469b34f76ae9d12ac20e.png)

・投稿のタイトルをクリックすると遷移できる

・投稿一覧ページの機能と同じ

・投稿に対し、コメントすることができる。

## ・ユーザー新規登録ページ
![](https://i.gyazo.com/29d50fb5bae5bd299f3aad4a98a2954b.jpg)

・ニックネーム、Eメール、パスワードを入力することで登録できる。

・facebook、googleのアカウントで簡単に登録可能。

## ・ユーザーログインページ
![](https://i.gyazo.com/a412a8e4a7f8fce8dda0f9dc59a86732.jpg)

・Eメール、パスワードを入力することでログイン可能。

・facebook、googleで登録していると簡単にログイン可能。

## ・新規投稿ページ

![](https://i.gyazo.com/6b2112347b1bae06e153088de88fc134.jpg)

・画像を選択し、あらすじ、感想を入力することで投稿が可能。

・プレビュー機能により、選択した画像を小さく表示。

## ・楽天検索ページ

### ＊著作権等の問題もありますので画像の表示は控えさせていただきます。

・購入したい絵本を検索すると楽天から情報を取得し表示させる。

・画像を選択すると楽天のサイトへ遷移。

# 工夫したポイント
・サイトの信用度を高めるためにドメインを取得して、SSL化したこと。

・dockerを開発環境で導入したこと。

・インフラをAWSで構築したこと。

・投稿数が増えるたびに、トップページの画面が広がり続け、見えにくくなるのを防ぐために、ページネーション機能を使い、投稿が一定数以上増えると、次ページに遷移できるようにしたこと。

・楽天APIを導入して、アプリケーションサイトから直接、楽天の商品を検索できるようにして、画像をクリックすることで楽天サイトの購入ページに遷移できるようにしたこと。

・いいね機能を追加し、投稿に対して、ユーザーが反応できるようにしたこと。

・Facebook・GoogleAPIを導入して、SNS認証できるようにし、新規登録やログインの簡略化したこと。

・awsで自動化デプロイできるようにしたこと。

・s3を使うことで画像のリンクが切れないようにしたこと。

# 使用技術(開発環境)

## フロントエンド
・HTML

・CSS(SCSS)

・Bootstrap4

・Javascript

## バックエンド
・Ruby2.6.5

・Ruby on Rails 6.0.3.4

## DB
・MySQL

## テスト
・RSpec(SystemSpec)

・FactoryBot

・Faker

## 本番環境
・AWS(EC2, S3, Route53)

## ソース管理
・GitHub, GitHubDesktop

# 課題や今後実装したい機能
・課題としては、現状、楽天の商品検索機能があるので、投稿を見て、気に入った絵本があればサイトから直接楽天のサイトに遷移し、購入することは可能ですが、投稿者にメリットがないので、投稿者の投稿を見て絵本を購入してもらうと、購入金額の何％かが投稿者に還元されるようにしたいと考えています。



# テーブル設計

## users テーブル

| Column         | Type   | Options     |
| -------------- | ------ | ----------- |
| email          | string | null: false |
| password       | string | null: false |
| nickname       | string | null: false |

### Association

- has_many :books
- has_many :comments
- has_many :likes, dependent: :destroy
- has_many :like_books, through: :likes, source: :book


## books テーブル

| Column     | Type       | Options                        |
| ------     | ------     | -----------                    |
| title      | string     | null: false                    |
| story      | text       | null: false                    |
| impression | text       | null: false                    |
| user       | references | null: false, foreign_key: true |

### Association

- has_many :comments
- belongs_to :user
- has_many :likes, dependent: :destroy
- has_many :liking_users, through: :likes, source: :user



## comments テーブル

| Column     | Type       | Options                        |
| ------     | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| user       | references | null: false, foreign_key: true |
| book       | references | null: false, foreign_key: true |


### Association

- belongs_to :users
- belongs_to :books

## likes テーブル

| Column     | Type       | Options                        |
| ------     | ---------- | ------------------------------ |
| user       | references | null: false, foreign_key: true |
| book       | references | null: false, foreign_key: true |


### Association

- belongs_to :users
- belongs_to :books

