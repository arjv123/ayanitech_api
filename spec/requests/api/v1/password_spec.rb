require 'swagger_helper'

RSpec.describe 'api/v1/password', type: :request do

  path '/api/v1/password/forgot' do

    post('forgot password') do
      tags 'Users'
      response(200, 'successful') do
        consumes 'application/json'
        parameter in: :body, schema: {
          type: :object,
          properties: {
            email: { type: :string }
          },
          required: %w[email]
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

  path '/api/v1/password/update' do

    post('update password') do
      tags 'Users'
      response(200, 'successful') do
      consumes 'application/json'
      parameter in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          token: { type: :string },
          password: { type: :string }
        },
        required: %w[email, token, password]
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

  path '/api/v1/password/reset' do

    post('reset password') do
      tags 'Users'
      security [bearerAuth: []]
      response(200, 'successful') do
        consumes 'application/json'
        parameter in: :body, schema: {
          type: :object,
          properties: {
            password: { type: :string },
            confirmation_password: { type: :string }
          },
          required: %w[password, confirmation_password ]
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
