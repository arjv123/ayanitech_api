module CheckJson
  extend ActiveSupport::Concern

  require "json"

  def valid_json?(json)
    begin
      JSON.parse(json)
      return true
    rescue Exception => e
      return false
    end
  end
end




