require 'httparty'

class OpenaiApi
  include HTTParty

  def initialize
    # your-resource-name - The name of your Azure OpenAI Resource.
    # deployment-id	- The name of your model deployment. You're required to first deploy a model before you can make calls
    # api-version	 - The API version to use for this operation. This follows the YYYY-MM-DD format.
    your_resource_name = Rails.application.credentials.your_resource_name
    deployment_id = Rails.application.credentials.deployment_id
    api_version = Rails.application.credentials.api_version
    @url = "https://#{your_resource_name}.openai.azure.com/openai/deployments/#{deployment_id}/completions?api-version=#{api_version}"
  end

  def generate_text(prompt, current_user)
    options = {
      headers: {
        "Content-Type": "application/json",
        "api-key": Rails.application.credentials.api_key
      },
      body: {
        "prompt": prompt,
        "max_tokens": current_user.max_tokens,
        "temperature": 1,
        "frequency_penalty": 0,
        "presence_penalty": 0,
        "top_p": 0.5,
        "stop": 'null'
      }.to_json,
      timeout: current_user.timeout
    }
    # Request for creating a completion for the provided prompt and parameters
    response = HTTParty.post(@url, options)
    completion = response["choices"][0]["text"]
  end

end
