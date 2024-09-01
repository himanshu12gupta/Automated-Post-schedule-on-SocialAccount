class CreateCalenders < ActiveRecord::Migration[7.0]
  def change
    create_table :calenders do |t|
      t.string :title
      t.time :handler_time
      t.references :handler, null: false, foreign_key: true

      t.timestamps
    end
  end
end
