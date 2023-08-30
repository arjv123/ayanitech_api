require 'swagger_helper'

RSpec.describe 'api/v1/conversations', type: :request do

  path '/api/v1/get_output' do
    # You'll want to customize the parameter types...
    parameter name: 'space_id', in: :path, type: :string, description: 'space_id'

    post('get_output conversation') do
      tags 'Conversations'
      security [bearerAuth: []]
      response(200, 'successful') do
        consumes 'application/json'
        parameter in: :body, schema: {
          type: :object,
          properties: {
            input: { type: :string }
          },
          required: %w[input tokens timeout]
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
