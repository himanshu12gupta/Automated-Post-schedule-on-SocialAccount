class CreateUserSocialAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_social_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :social_account, null: false, foreign_key: true
      t.string :access_token

      t.timestamps
    end
  end
end
