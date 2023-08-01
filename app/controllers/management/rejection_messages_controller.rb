class Management::RejectionMessagesController < Management::BaseController
  skip_authorization_check
  def new
    @receiver = User.find(params[:user_id])
    @direct_message = RejectionMessage.new(receiver: @receiver)
  end

  def create
    @sender = current_user
    @receiver = User.find(params[:user_id])

    @direct_message = RejectionMessage.new(parsed_params)
    if @direct_message.save
      Mailer.rejection_message_for_receiver(@direct_message).deliver_later
      redirect_to management_users_path, notice: I18n.t("flash.actions.create.direct_message")
    else
      render :new
    end
  end

 


  private

    def direct_message_params
      params.require(:rejection_message).permit(allowed_params)
    end

    def allowed_params
      [:title, :body]
    end

    def parsed_params
      direct_message_params.merge(sender: @sender, receiver: @receiver)
    end
end
