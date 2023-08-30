class UsersSerializer < ApplicationSerializer

  attributes :name, :email, :role, :max_tokens, :timeout
end
