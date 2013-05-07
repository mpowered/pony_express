class PonyExpress::Letter
  attr_accessor :message, :params
  attr_reader :sent, :send_async, :recipients

  alias :sent? :sent
  alias :send_async? :send_async

  def initialize
    self.sent = false
    self.send_async = false
  end

  # Sets the recipient attribute with validation.
  # An exception is raised if invalid recipients
  # are provided.
  def set_recipients(recipients)
    if PonyExpress::Recipients.new.valid?(recipients)
      self.recipients = recipients
    else
      raise RuntimeError, "Attempted to send a Pony to an invalid recipient"
    end
  end

  def valid?
    recipients.present? && message.present?
  end

  def mark_as_sent!
    self.sent = true
  end

  def set_async_flag!
    self.send_async = true
  end
  private
    attr_writer :sent, :send_async, :recipients
end