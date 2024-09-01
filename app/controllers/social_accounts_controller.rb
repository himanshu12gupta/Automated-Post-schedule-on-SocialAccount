class SocialAccountsController < ApplicationController
  before_action :set_social_account, only: %i[ show edit update destroy ]

  # GET /social_accounts or /social_accounts.json
  def index
    @social_accounts = SocialAccount.all
  end

  # GET /social_accounts/1 or /social_accounts/1.json
  def show
    @social_account = SocialAccount.find(params[:id])
    @social_account.handlers
  end

  # GET /social_accounts/new
  def new
    @social_account = SocialAccount.new
  end

  # GET /social_accounts/1/edit
  def edit
  end

  # POST /social_accounts or /social_accounts.json
  def create
    @social_account = SocialAccount.new(social_account_params)

    respond_to do |format|
      if @social_account.save
        format.html { redirect_to social_account_url(@social_account), notice: "Social account was successfully created." }
        format.json { render :show, status: :created, location: @social_account }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @social_account.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @social_account.update(social_account_params.except(:access_token))
        user_social_account = UserSocialAccount.find_or_initialize_by(user_id: current_user.id, social_account_id: @social_account.id)
        if params[:social_account][:access_token].present?
          user_social_account.access_token = params[:social_account][:access_token]
          user_social_account.save
        end
  
        format.html { redirect_to social_accounts_url, notice: "Social account was successfully updated." }
        format.json { render :show, status: :ok, location: @social_account }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @social_account.errors, status: :unprocessable_entity }
      end
    end
  end  

  # DELETE /social_accounts/1 or /social_accounts/1.json
  def destroy
    @social_account.destroy

    respond_to do |format|
      format.html { redirect_to social_accounts_url, notice: "Social account was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_social_account
      @social_account = SocialAccount.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def social_account_params
      params.require(:social_account).permit(:name, :platform) # Add more fields as necessary
    end
end
