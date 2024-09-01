require 'net/http'
require 'uri'
require 'json'
class HandlersController < ApplicationController
  before_action :set_handler, only: %i[ show edit update destroy ]

  # GET /handlers or /handlers.json
  def index
    @handlers = Handler.all
  end

  # GET /handlers/1 or /handlers/1.json
  def show
    post_id = @handler.post_id
    # access_token = @handler.social_account.user_social_accounts.first
    access_token = "EAAP9eOTyMckBOxxjX50ARZAw0PruFYYnzIfAQ1ZBy1gjf9asUZCb2nQ6QBLGSMFZANNbwNrgZC7LvdLQE4dTdfH3NdFKrwjaMeHqpKM3w7fRIQXraJR7fHJKAfQw8IZCkfzkQzypFrQ75WYiORjJy9MDd2ZClq0GdqHjCWvlePI2a2QOPEys86iOaFayu30dn5t"
    like_url = URI("https://graph.facebook.com/#{post_id}?fields=likes.summary(true)&access_token=#{access_token}")
    like_response = Net::HTTP.get(like_url)
    comment_url = URI("https://graph.facebook.com/#{post_id}/comments?fields=from,message&access_token=#{access_token} ")
    comment_response = Net::HTTP.get(comment_url)
    comment_data = JSON.parse(comment_response)
    like_data = JSON.parse(like_response)
    @like_data = like_data["likes"]["data"]
    @total_likes = like_data.dig('likes', 'summary', 'total_count') || 0
    @comment_counts = comment_data["data"].count
    @total_comment = comment_data["data"]
  end



  # GET /handlers/1/edit
  def edit
  end

  # POST /handlers or /handlers.json
  def new
    @handler = Handler.new
    @social_accounts = SocialAccount.all
  end

  def create
    selected_social_account_ids = params.dig(:handler, :social_account_ids) || []
    ids = selected_social_account_ids.reject(&:blank?)
  
    errors = []
  
    ids.each do |id|
      social_account = SocialAccount.find_by(id: id)
  
      if social_account.nil?
        errors << "Social account with ID #{id} does not exist."
        next
      end
      @handler = Handler.new(handler_params)
      @handler.social_account_id = id
      @handler.social_account_id = id
  
      unless @handler.save
        errors << @handler.errors.full_messages.to_sentence
        break
      end
       PostWorker.perform_async(@handler.id)
    end
  
    if errors.empty?
      redirect_to calendars_path, notice: 'Handler was successfully created.'
      # All records are successfully saved
    else
      flash.now[:alert] = errors.join(', ')
      render :new
    end
  end
  
  def update
    if @handler.update(handler_params)
      redirect_to @handler, notice: 'Handler was successfully updated.'
    else
      @platforms = SocialAccount::PLATFORMS
      render :edit
    end
  end

  def destroy
    @handler.destroy

    respond_to do |format|
      format.html { redirect_to handlers_url, notice: "Handler was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_handler
      @handler = Handler.find(params[:id])
    end
  
    def handler_params
      params.require(:handler).permit(:name, :text, :time, :social_account_id, :image)
    end
    
    
end
