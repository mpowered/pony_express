require "pony_express/engine"

module PonyExpress
  def self.to(*recipients)
    PonyExpress::Message.new.to(*recipients)
  end

  def self.send_pony(message, params = {})
    PonyExpress::Message.new.send_pony(message, params)
  end

  def self.send_pony_async(message, params = {})
    PonyExpress::Message.new.send_pony_async(message, params)
  end
end
