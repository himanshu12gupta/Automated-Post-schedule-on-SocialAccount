class SchedulePost
  include Rails.application.routes.url_helpers
  include HTTParty
  base_uri 'https://graph.facebook.com/v20.0/'

  def initialize(data)
    @data = data
  end

  def call
    verify_type
  end

  private

  def facebook_post(account)
    token = "EAAP9eOTyMckBOxxjX50ARZAw0PruFYYnzIfAQ1ZBy1gjf9asUZCb2nQ6QBLGSMFZANNbwNrgZC7LvdLQE4dTdfH3NdFKrwjaMeHqpKM3w7fRIQXraJR7fHJKAfQw8IZCkfzkQzypFrQ75WYiORjJy9MDd2ZClq0GdqHjCWvlePI2a2QOPEys86iOaFayu30dn5t"
    if @data.image.present?
      url = @data.image.url
      body = {
        message: @data.text,
        url: url,
        published: true
      }.to_json
  
      api_url = "/me/photos" 
    else
      body = {
        message: @data.text,
        published: true
      }.to_json
  
      api_url = "/me/feed"  
    end
    begin
      response = self.class.post(
        api_url,
        body: body,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      )
      if response.success?
        @data.update(post_id: response["id"] )
        Rails.logger.info("Post successfully scheduled: #{response.body}")
      else
        Rails.logger.error("Failed to schedule post: #{response.code} - #{response.body}")
      end
    rescue StandardError => e
      Rails.logger.error("API request failed: #{e.message}")
    end
  end

  def verify_type
    facebook_post(@data) if @data.social_account.platform == "Facebook"
  end
end
