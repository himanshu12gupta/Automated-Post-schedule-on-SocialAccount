class Calender < ApplicationRecord
  belongs_to :handler

  def start_time
    handler_time
  end
  

end
