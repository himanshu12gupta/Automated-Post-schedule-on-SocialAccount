class AnalyticsController < ApplicationController
  def index
    @analytics = Analytic.all
  end
end
