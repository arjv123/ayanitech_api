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
require 'rails_helper'

RSpec.describe Space, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
