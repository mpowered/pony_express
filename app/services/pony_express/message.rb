class PonyExpress::Message
  attr_accessor :recipients, :message, :params
  attr_reader :sent, :send_async

  alias :sent? :sent
  alias :send_async? :send_async

  def initialize
    self.sent = false
    self.send_async = false
  end

  def to(*recipients)
    self.recipients = recipients
    validate_recipients
    send_if_valid
  end

  def send_pony(message, params = {})
    self.message = message
    self.params = params
    send_if_valid
  end

  def send_pony_async(message, params = {})
    set_async_flag!
    send_pony(message, params)
  end

  private
    attr_writer :sent, :send_async

    def send_if_valid
      if locked_and_loaded?
        mark_as_sent!
        send!
      end
      return self
    end

    def mark_as_sent!
      self.sent = true
    end

    def set_async_flag!
      self.send_async = true
    end

    def send!
      if send_async?
        PonyExpressSenderWorker.perform_async(recipients, message, params)
      else
        PonyExpress::Recipients.new.details_for(recipients) do |mount_point, psk|
          HTTParty.post("#{mount_point}/messages/#{message}", query: {params: params}, basic_auth: { username: 'pony_express', :password => psk})
        end
      end
    end

    def validate_recipients
      unless PonyExpress::Recipients.new.valid?(self.recipients)
        raise RuntimeError, "Attempted to send a Pony to an invalid recipient"
      end
    end

    def locked_and_loaded?
      recipients.present? && message.present?
    end
end