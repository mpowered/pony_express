class PonyExpress::Recipients
  attr_reader :recipients_config

  def initialize
    @recipients_config = PonyExpress::Config.recipients
  end

  def list
    address_book.keys
  end

  def valid?(recipients)
    (recipients.map(&:to_s) - list).empty?
  end

  def details_for(recipients)
    recipients.each do |recipient|
      yield details_for_recipient(recipient)['mount_point'], details_for_recipient(recipient)['psk']
    end
  end

  def address_book
    recipients_config.each_with_object({}) do |config, hash|
      hash[config.first] = config.last['mount_point']
    end
  end

  def details_for_recipient(recipient)
    recipients_config[recipient.to_s]
  end
end