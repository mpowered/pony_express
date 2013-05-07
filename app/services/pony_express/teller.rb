class PonyExpress::Teller
  attr_reader :letter

  def initialize
    @letter = PonyExpress::Letter.new
  end

  # Sets the recipients for the letter.
  # Will deliver if the letter is complete.
  def to(*recipients)
    letter.set_recipients(recipients)
    send_if_valid
    return self
  end

  # Sets the body of the letter.
  # Will deliver if the letter is complete.
  def send_pony(message, params = {})
    letter.message = message
    letter.params = params
    send_if_valid
    return self
  end

  # Sets the body of the letter.
  # Will deliver as a background job if the letter is complete.
  def send_pony_async(message, params = {})
    letter.set_async_flag!
    send_pony(message, params)
  end

  private
    def send_if_valid
      if letter.valid?
        PonyExpress::Pony.new(letter).deliver
        letter.mark_as_sent!
        return true
      else
        return false
      end
    end
end