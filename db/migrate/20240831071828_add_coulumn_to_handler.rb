class AddCoulumnToHandler < ActiveRecord::Migration[7.0]
  def change
    add_column :handlers, :text, :string
    add_column :handlers, :media, :string
    add_column :handlers, :time, :datetime
  end
end
