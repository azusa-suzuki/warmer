class ChngeUsersColumns < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :name_kana, :string
    remove_column :users, :postal_code, :string
    remove_column :users, :address, :string
    remove_column :users, :phone, :string
    add_column :users, :handle_name, :string
    add_column :users, :profile, :string, :default => 'こんにちは！', :null => false
    add_column :users, :prefecture, :integer, :default => 0, :null => false
  end
end
