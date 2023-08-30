# frozen_string_literal: true

class Api::V1::Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_user_update_params, only: :update
  respond_to :json

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.send_signup_email(@user).deliver_later(wait: 5.seconds)
      render_success("Signed up sucessfully.",
        UsersSerializer.new(@user).serializable_hash)
    else
      render_errors(@user)
    end
  end

  def update
   if @user.update_columns( max_tokens: params[:user][:max_tokens],
                            timeout: params[:user][:timeout])
      render_success("Update sucessfully.",
                              UsersSerializer.new(@user).serializable_hash)
   else
      render_errors(@user)
   end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end

  def respond_with(resource, _opts = {})
    if request.method == "POST" && resource.persisted?
      render_success("Signed up sucessfully.",
        UsersSerializer.new(resource).serializable_hash)
    elsif request.method == "DELETE"
      render_success("Account deleted successfully.")
    else
      render_errors(resource)
    end
  end

end
