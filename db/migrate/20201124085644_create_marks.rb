class CreateMarks < ActiveRecord::Migration[5.2]
  def change
    create_table :marks do |t|
      t.integer :user_id
      t.integer :invite_id

      t.timestamps
    end
  end
end
