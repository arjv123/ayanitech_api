class SpacesSerializer < ApplicationSerializer
  attributes :id, :name
  # has_many :conversations, :serializer => ConversationsSerializer

  # attributes :conversations do |object|
  #   ConversationsSerializer.new(object.conversations).serializable_hash
  # end
end
