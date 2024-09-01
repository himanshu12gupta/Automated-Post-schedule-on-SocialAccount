class Handler < ApplicationRecord
  belongs_to :social_account
  has_one_attached :image
  has_many :calendars
  has_many_attached :media
  after_create :create_calendars
  private

  def create_calendars
    Calender.create(handler_time: time,handler_id: id,title: social_account.platform)
  end
end
