class PonyExpress::Pony
  attr_reader :letter, :recipients

  def initialize(letter)
    @letter = letter
    @recipients = letter.recipients
  end

  def deliver
    return deliver_later if letter.send_async?
    return deliver_now
  end

  def deliver_now
    PonyExpress::Recipients.new.details_for(recipients) do |mount_point, psk|
      HTTParty.post(
        "#{mount_point}/messages/#{letter.message}",
        body: {params: letter.params},
        basic_auth: { username: 'pony_express', :password => psk},
        verify: false
      )
    end
  end

  def deliver_later
    PonyExpressSenderWorker.perform_async(recipients, letter.message, letter.params)
  end
end
