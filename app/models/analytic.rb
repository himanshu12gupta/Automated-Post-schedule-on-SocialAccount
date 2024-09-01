class Analytic < ApplicationRecord
  belongs_to :handler

  enum platform: { facebook: 0, instagram: 1, linkedin: 2 }

  validates :platform, presence: true
  validates :metric_type, presence: true
  validates :value, presence: true
  validates :timestamp, presence: true
end
