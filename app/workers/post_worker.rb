class PostWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform(handler_id)
   handler = Handler.find(handler_id)
   SchedulePost.new(handler).call
   InstaPost.new(handler).call
  end
end
