# frozen_string_literal: true

class Api::V1::Users::SessionsController < Devise::SessionsController
  respond_to :json


  private

  def respond_with(resource, _opts = {})
    render_success('Logged in sucessfully.',UsersSerializer.new(resource).serializable_hash)
  end

  def respond_to_on_destroy
    current_user ? log_out_success : log_out_failure
  end

  def log_out_success
    render_success("logged out successfully.")
  end

  def log_out_failure
    show_error("Couldn't find an active session.")
  end
end
