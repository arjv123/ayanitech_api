# frozen_string_literal: true

require 'factory_bot_rails'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end

module FactoryBot
  module Syntax
    module Methods
      def upload_file(file_name)
        path = Rails.root.join('spec', 'fixtures', file_name)
        Rack::Test::UploadedFile.new(path)
      end
    end
  end
end
