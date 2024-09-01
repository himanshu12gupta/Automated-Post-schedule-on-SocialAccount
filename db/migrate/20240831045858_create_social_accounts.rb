class CreateSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :social_accounts do |t|
      t.references :handler, null: false, foreign_key: true
      t.string :platform

      t.timestamps
    end
  end
end
