class CalendarsController < ApplicationController
  def index
    @calendars = Calender.all
  end
end
