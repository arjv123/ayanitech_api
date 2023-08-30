class ConversationWorker
  include Sidekiq::Worker

  def perform(input, output, space_id, user_id)
    user = User.find(user_id)
    Rails.logger.info user
    Rails.logger.info 'creating conversation record'
    user.conversations.create(input: input, output: output, space_id: space_id)
    Rails.logger.info 'created conversation record'
  end
end
