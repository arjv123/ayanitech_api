require 'swagger_helper'

RSpec.describe 'api/v1/users', type: :request do

 path '/api/v1/users' do

  post 'User Signup' do
    tags 'Users'
    consumes 'application/json'
    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        user: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string },
            name: {type: :string}
          },
          required: ['email', 'password', 'name', 'role']
        }
      }
    }
    response '201', 'User created' do
      run_test!
    end
  end
end

path '/api/v1/users/sign_in' do

  post 'User Signin' do
    tags 'Users'
    consumes 'application/json'
    parameter name: :user, in: :body, schema: {
      type: :object,
      properties: {
        user: {
          type: :object,
          properties: {
            email: { type: :string },
            password: { type: :string }
          },
          required: ['email', 'password']
        }
      }
    }
    response '201', 'Session created' do
      run_test!
    end
  end
end

  path '/api/v1/users/sign_out' do

    delete('delete session') do
      tags 'Users'
      security [bearerAuth: []]
      response(200, 'successful') do

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
