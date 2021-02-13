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
- has_many :transactions

## products テーブル

| Column            | Type       | Options                        |
| ----------------- | ---------- | ------------------------------ |
| name              | string     | null: false                    |
| description       | text       | null: false                    |
| category          | string     | null: false                    |
| condition         | string     | null: false                    |
| delivery_fee      | string     | null: false                    |
| area              | string     | null: false                    |
| days              | string     | null: false                    |
| price             | integer    | null: false                    |
| transaction_status| boolean    | null: false                    |
| user_id           | references | null: false, foreign_key: true |
| transaction_id    | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- has_one :transaction

## transactions テーブル

| Column         | Type         | Options                        |
| -------------- | ------------ | ------------------------------ |
| user_id        | references   | null: false, foreign_key: true |
| product_id     | references   | null: false ,foreign_key: true |
| address_id     | references   | null: false, foreign_key: true |
| card_id        | references   | null: false ,foreign_key: true |

### Association

- belongs_to :user
- belongs_to :production
- has_one :address
- has_one :card

## addresses テーブル

| Column          | Type         | Options                        |
| --------------- | ------------ | ------------------------------ |
| post_code       | string       | null: false                    |
| prefecture      | string       | null: false                    |
| block           | string       | null: false                    |
| building        | string       |                                |
| phone_number    | integer      | null: false                    |
| city            | string       | null: false                    |
| transaction_id  | references   | null: false, foreign_key: true |

### Association

- belongs_to :transaction

## carss テーブル

| Column             | Type         | Options                        |
| ------------------ | ------------ | ------------------------------ |
| card_number        | string       | null: false                    |
| security_code      | string       | null: false                    |
| dead_line          | string       | null: false                    |
| transaction_id     | string       | null: false, foreign_key: true |

### Association

- belongs_to :transaction
