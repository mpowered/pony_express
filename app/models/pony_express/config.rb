class PonyExpress::Config
  attr_reader :config

  def initialize
    @config = YAML::load_file(File.join(Rails.root, "config/pony_express.yml"))
  end

  def self.secret_key
    self.new.config['my_psk']
  end

  def self.recipients
    self.new.config['recipients']
  end
end