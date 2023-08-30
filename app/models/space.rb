# == Schema Information
#
# Table name: spaces
#
#  id         :bigint           not null, primary key
#  deleted_at :datetime
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_spaces_on_deleted_at  (deleted_at)
#  index_spaces_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
class Space < ApplicationRecord
  #============== Validations =================================
  validates :name, presence: true

  #============== Associations =================================
  belongs_to :user
  has_many :conversations, dependent: :destroy

  #============= Callbacks ======================================
end
