class CreateSocialAttacheds < ActiveRecord::Migration[7.0]
  def change
    create_table :social_attacheds do |t|
      t.references :social_account, null: false, foreign_key: true
      t.datetime :time
      t.string :text
      t.string :media

      t.timestamps
    end
  end
end
