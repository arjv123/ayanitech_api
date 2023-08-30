class UserMailer < ApplicationMailer

  def send_signup_email(user)
    @user  = user
    mail( :to =>  @user.email,
    :subject => 'Thanks for signing up!' )
  end

  def send_token(user)
    @user  = user
    @token = @user.reset_password_token
    @url  = "http://localhost:3001/reset_password/#{@token}"
      mail( :to =>  @user.email,
    :subject => 'Forgot password Token' )
  end
end
