class PonyExpress::Recipients
  attr_reader :recipients

  def initialize
    @recipients =  {
      :toolkit => 'toolkit.mpowered.io',
      :sms => 'toolkit.mpowered.io'
    }
  end

  def list
    recipients.keys
  end

  def valid?(recipients)
    (recipients - list).empty?
  end
end