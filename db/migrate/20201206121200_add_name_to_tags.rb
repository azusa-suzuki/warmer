class AddNameToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :name, :string
    add_column :tags, :invite_id, :integer
    add_column :tags, :post_id, :integer
  end
end
