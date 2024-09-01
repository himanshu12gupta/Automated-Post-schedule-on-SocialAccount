class DeleteColumnHandlerId < ActiveRecord::Migration[7.0]
  def change
    remove_column :social_accounts, :handler_id, :integer    
    add_column :handlers, :social_account_id, :integer
    
  end
end
