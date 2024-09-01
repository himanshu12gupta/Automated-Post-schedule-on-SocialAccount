# app/models/social_account.rb
class SocialAccount < ApplicationRecord
  has_many :handlers
  has_many :user_social_accounts
  has_many :users, through: :user_social_accounts

  PLATFORM_OPTIONS = ['Instagram', 'LinkedIn', 'Facebook']
end
