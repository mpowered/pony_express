class PonyExpress::Recipients
  attr_reader :recipients_lookup

  def initialize
    @recipients_lookup =  {
      :toolkit => 'http://sms.dev/pony',
      :sms => 'http://sms.dev/pony'
    }
  end

  def list
    recipients_lookup.keys
  end

  def valid?(recipients)
    (recipients.map(&:to_sym) - list).empty?
  end

  def addresses_for(recipients)
    recipients.each do |recipient|
      yield recipients_lookup[recipient.to_sym]
    end
  end
end