class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :user_social_accounts
  has_many :social_accounts, through: :user_social_accounts
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:github]


  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(email: data['email']).first
     unless user
         user = User.create(
           email: data['email'],
            password: Devise.friendly_token[0,20]
         )
     end
    user
  end
end
