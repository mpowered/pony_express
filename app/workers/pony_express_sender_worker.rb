class PonyExpressSenderWorker
  include Sidekiq::Worker

  sidekiq_options queue: "pony_express_#{Rails.env}",
                  unique: true, 
                  retry: 3

  def perform(recipients, message, params)
    PonyExpress.to(*recipients).send_pony(message, params)
  end
end