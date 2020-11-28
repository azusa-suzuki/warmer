class CreateInviteComments < ActiveRecord::Migration[5.2]
  def change
    create_table :invite_comments do |t|
      t.integer :user_id
      t.integer :invite_id
      t.text :comment

      t.timestamps
    end
  end
end
