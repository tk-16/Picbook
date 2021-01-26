# テーブル設計

## users テーブル

| Column     | Type   | Options     |
| --------   | ------ | ----------- |
| email      | string | null: false |
| password   | string | null: false |
| name       | string | null: false |

### Association

- has_many :books
- has_many :comments


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


## comments テーブル

| Column     | Type       | Options                        |
| ------     | ---------- | ------------------------------ |
| text       | text       | null: false                    |
| user       | references | null: false, foreign_key: true |
| book       | references | null: false, foreign_key: true |


### Association

- belongs_to :users
- belongs_to :books

