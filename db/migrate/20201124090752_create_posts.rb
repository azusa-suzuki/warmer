class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :image_id
      t.string :title
      t.text :content
      t.integer :sex, default: 0, null: false
      t.integer :age, default: 0, null: false
      t.integer :type, default: 0, null: false

      t.timestamps
    end
  end
end
