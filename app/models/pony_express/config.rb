class PonyExpress::Config
  attr_reader :config

  def initialize
    @config = YAML::load_file(File.join(Rails.root, "config/pony_express.yml"))
  end

  def self.secret_key
    config['my_psk']
  end

  def self.recipients
    config['recipients']
  end

  def self.queue_prefix
    config['queue_prefix'] || Rails.application.class.parent_name.underscore
  end

  def self.config
    self.new.config
  end
end