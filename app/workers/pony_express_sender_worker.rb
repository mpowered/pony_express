class PonyExpressSenderWorker
  include Sidekiq::Worker

  sidekiq_options queue: "#{PonyExpress::Config.queue_prefix}_pony_express_#{Rails.env}", lock: :until_executed, on_conflict: :replace, retry: 3

  def perform(recipients, message, params)
    PonyExpress.to(*recipients).send_pony(message, params)
  end
end
