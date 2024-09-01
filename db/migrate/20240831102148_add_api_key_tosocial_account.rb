class AddApiKeyTosocialAccount < ActiveRecord::Migration[7.0]
  def change
    add_column :social_accounts, :api_key, :text
  end
end
