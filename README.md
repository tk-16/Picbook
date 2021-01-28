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

