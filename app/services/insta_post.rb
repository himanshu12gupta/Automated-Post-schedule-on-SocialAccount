class InstaPost
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

  def insta_post(account)
    token = "EAAP9eOTyMckBOxxjX50ARZAw0PruFYYnzIfAQ1ZBy1gjf9asUZCb2nQ6QBLGSMFZANNbwNrgZC7LvdLQE4dTdfH3NdFKrwjaMeHqpKM3w7fRIQXraJR7fHJKAfQw8IZCkfzkQzypFrQ75WYiORjJy9MDd2ZClq0GdqHjCWvlePI2a2QOPEys86iOaFayu30dn5t"
    url = URI.encode_www_form_component(@data.image.url)
    body = {
      message: @data.text,
      url: url,
      published: true
    }.to_json
  
    api_url = "/17841469014768029/media?image_url=#{url}&caption=#{@data.text}"
    begin
      response = self.class.post(
        api_url,
        headers: {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{token}"
        }
      )
      if response.success?
        next_url = "/17841469014768029/media_publish?creation_id=#{response["id"]}"
        publish_response = self.class.post(
          next_url,
          headers: {
            'Content-Type' => 'application/json',
            'Authorization' => "Bearer #{token}"
          }
        )
        if publish_response.success?
          Rails.logger.info("Post successfully scheduled: #{publish_response.body}")
        else
          Rails.logger.error("Failed to publish post: #{publish_response.code} - #{publish_response.body}")
        end
        Rails.logger.info("Post successfully scheduled: #{response.body}")
      else
        Rails.logger.error("Failed to schedule post: #{response.code} - #{response.body}")
      end
    rescue StandardError => e
      Rails.logger.error("API request failed: #{e.message}")
    end
  end

  def verify_type
    insta_post(@data) if @data.social_account.platform == "Instagram"
  end
end
