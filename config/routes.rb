# == Route Map
#

require 'sidekiq/web'


Rails.application.routes.draw do
  devise_for :users, path: 'api/v1/users', controllers: {
    sessions: 'api/v1/users/sessions',
    registrations: 'api/v1/users/registrations',
  }, defaults: { format: :json }
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  mount Sidekiq::Web => "/sidekiq"

  namespace :api do
    namespace :v1 do
      resources :spaces, except: %i[new edit]
      post 'password/forgot', to: 'password#forgot'
      post 'password/update', to: 'password#update_password'
      post 'password/reset', to: 'password#reset'
      post 'get_output', to: 'conversations#get_output'
    end
  end
  get '/*a', to: 'application#not_found'
end
