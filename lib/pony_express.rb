require "pony_express/engine"

module PonyExpress
  def self.to(*recipients)
    PonyExpress::Teller.new.to(*recipients)
  end

  def self.send_pony(message, params = {})
    PonyExpress::Teller.new.send_pony(message, params)
  end

  def self.send_pony_async(message, params = {})
    PonyExpress::Teller.new.send_pony_async(message, params)
  end
end
