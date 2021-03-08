# テーブル設計

## users テーブル

| Column             | Type     | Options     |
| ---------------    | -------- | ----------- |
| nick_name          | string   | null: false |
| email              | string   | null: false |
| encrypted_password | string   | null: false |
| last_name          | string   | null: false |
| first_name         | string   | null: false |
| last_name_kana     | string   | null: false |
| first_name_kana    | string   | null: false |
| birth_day          | date     | null: false |

### Association

- has_many :products
- has_many :orders
- has_many :comments

## products テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| category_id       | integer    | null: false                    |
| condition_id      | integer    | null: false                    |
| delivery_fee_id   | integer    | null: false                    |
| prefecture_id     | integer    | null: false                    |
| days_id           | integer    | null: false                    |
| price             | integer    | null: false                    |
| user              | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :order
- has_many :comments

## orders テーブル

| Column         | Type         | Options                        |
| -------------- | ------------ | ------------------------------ |
| user        | references   | null: false, foreign_key: true |
| product     | references   | null: false ,foreign_key: true |
### Association

- belongs_to :user
- belongs_to :production
- has_one :address

## addresses テーブル

| Column          | Type         | Options                        |
| --------------- | ------------ | ------------------------------ |
| post_code       | string       | null: false                    |
| prefecture_id   | integer       | null: false                    |
| block           | string       | null: false                    |
| building        | string       |                                |
| phone_number    | string       | null: false                    |
| city            | string       | null: false                    |
| order     | references   | null: false, foreign_key: true |

### Association

- belongs_to :order

## comments テーブル

| Column          | Type         | Options                        |
| --------------- | ------------ | ------------------------------ |
| message         | text         | null: false                    |
| user            | references   | foreign_key: true              |
| product         | references   | foreign_key: true              |


### Association

- belongs_to :user
- belongs_to :product

## likes テーブル

| Column          | Type         | Options                        |
| --------------- | ------------ | ------------------------------ |
| user            | references   | foreign_key: true              |
| product         | references   | foreign_key: true              |


### Association

- belongs_to :user
- belongs_to :product

## categories テーブル

| Column          | Type         | Options                        |
| --------------- | ------------ | ------------------------------ |
| name            | string       | null: false                    |
| ancestry        | string       |                                |


### Association

- has_many :products
- has_ancestry

