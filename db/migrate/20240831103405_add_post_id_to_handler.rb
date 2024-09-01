class AddPostIdToHandler < ActiveRecord::Migration[7.0]
  def up
    add_column :handlers, :post_id, :string
  end

  def down
    remove_column :handlers, :post_id
  end
end
