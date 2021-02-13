class AddColumnToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :first_name_kana, :string
    add_column :users, :last_name_kana, :string
    add_column :users, :birth_day, :date

  end
end
