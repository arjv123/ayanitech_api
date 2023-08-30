class Api::V1::PasswordController < ApplicationController
  before_action :authenticate_user!, only: [:reset]

  def forgot
    # check if email is present
    if params[:email].blank?
      return show_error('Email not present.')
    end
    # if present find user by email
    user = User.find_by(email: params[:email])

    if user.present?
      #generate pass token
      user.generate_password_token!

      UserMailer.send_token(user).deliver_later(wait: 5.seconds)
      render_success('You have recieved token in email!')
    else
      show_error('Email address not found. Please check and try again.')
    end
  end

  def update_password
    token = params[:token].to_s

    if params[:token].blank?
      return show_error('Token not present.')
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])

        render_success('You have successfuly changed your password.')
      else
        render_errors(user)
      end
    else
      show_error('Link not valid or expired. Try generating a new link.')
    end
  end

  def reset
    pass = params[:password]
    c_pass = params[:confirmation_password]
    return show_error('Password does not match. Please try again later.') unless pass.eql?(c_pass)
    return show_error('should include 1 uppercase letter, 1 number, 1 special character') unless current_user.valid_password?(pass)

    current_user.reset_password(params[:password], params[:confirmation_password])
    render json: {status: 'success', message: 'You have successfuly reset your password.'}, status: :ok
  end


end
