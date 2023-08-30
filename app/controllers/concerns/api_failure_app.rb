class ApiFailureApp < Devise::FailureApp
  def http_auth_body
    return super unless request_format == :json
    {
      status: 'error',
      message: i18n_message,
      data: {}
    }.to_json
  end
end
