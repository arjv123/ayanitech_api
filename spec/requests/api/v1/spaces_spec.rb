require 'swagger_helper'

RSpec.describe 'api/v1/spaces', type: :request do

  path '/api/v1/spaces' do
    get('list spaces') do
      tags 'Spaces'
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

    post('create space') do
      tags 'Spaces'
      security [bearerAuth: []]
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :space, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: %w[name]
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

  path '/api/v1/spaces/{id}' do
    # You'll want to customize the parameter types...
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show space') do
      tags 'Spaces'
      security [bearerAuth: []]
      response(200, 'successful') do
        let(:id) { '123' }

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

    patch('update space') do
      tags 'Spaces'
      security [bearerAuth: []]
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :space, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: %w[name]
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

    put('update space') do
      tags 'Spaces'
      security [bearerAuth: []]
      response(200, 'successful') do
        consumes 'application/json'
        parameter name: :space, in: :body, schema: {
          type: :object,
          properties: {
            name: { type: :string }
          },
          required: %w[name]
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

    delete('delete space') do
      tags 'Spaces'
      security [bearerAuth: []]
      response(200, 'successful') do
        let(:id) { '123' }

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
