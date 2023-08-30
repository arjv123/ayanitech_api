class ConversationsSerializer < ApplicationSerializer

  # belongs_to :space, :serializer => SpacesSerializer
  attributes :input, :output, :sequence
end
