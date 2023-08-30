# frozen_string_literal: true

# rubocop:disable Lint/DuplicateBranch
class ApplicationController < ActionController::API
  before_action :set_default_response_format
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Exception, with: :show_error
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  include Pundit::Authorization

  def render_errors(object)
    render json: {status: 'error', message: object.errors.full_messages.join(", "), data: {}}, status: :unprocessable_entity
  end

  def render_success(message = '', data = {})
    render json: {status: 'success', message: message, data: data}, status: :ok
  end

  def show_error(exception)
    Rails.logger.info 'error_generic'
    Rails.logger.info exception
    render json: { status: 'error', message: exception, data: {} }, status: :unprocessable_entity
  end

  def record_not_found(exception)
    Rails.logger.info 'error_generic'
    Rails.logger.info exception
    render json: { status: 'error', message: exception, data: {} }, status: :unprocessable_entity
  end

  def user_not_authorized
    render json: { status: 'error', message: 'You are not authorized to perform this action' }, status: :unprocessable_entity
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:email, :password)
    end

    attributes = %i[email role name]
    devise_parameter_sanitizer.permit(:sign_up, keys: attributes)
  end

  private

  def set_default_response_format
    request.format = :json
  end
end
# rubocop:enable Lint/DuplicateBranch
