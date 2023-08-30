# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  input      :text
#  output     :text
#  sequence   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  space_id   :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_conversations_on_deleted_at  (deleted_at)
#  index_conversations_on_sequence    (sequence)
#  index_conversations_on_space_id    (space_id)
#  index_conversations_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (space_id => spaces.id)
#  fk_rails_...  (user_id => users.id)
#
class Conversation < ApplicationRecord
    #============== Validations =================================
    validates :input, :output, presence: true

    #============== Associations =================================
    belongs_to :user
    belongs_to :space

    #============= Callbacks ======================================
    before_create :auto_increment


    private

    def auto_increment
      self.sequence = increment
    end

    def increment
      max = Conversation.maximum(:sequence)

      max.blank? ? 1 : max.next
    end
end
