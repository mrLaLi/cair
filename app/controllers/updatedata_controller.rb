class UpdatedataController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_lock, only: [:new, :create, :show]
  skip_authorization_check
  
  def show

  end
  def new
    @update = Verification::Updatedata.new
  end

  def create
    @update = Verification::Updatedata.new(update_params.merge(user: current_user))
    if @update.save
      redirect_to account_path, notice: t("flash.actions.save_changes.notice")
    else
      render :new
    end
  end

  

  private

    def update_params
      params.require(:update).permit(allowed_params)
    end

    def allowed_params
      [:document_number, :document_type, :date_of_birth, :postal_code, :image, :terms_of_service]
    end

end
