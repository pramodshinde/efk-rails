Rails.application.configure do
  config.lograge.enabled = true
  config.lograge.keep_original_rails_log = true
  config.lograge.base_controller_class = 'ActionController::API'

  config.lograge.logger = ActiveSupport::Logger.new "#{Rails.root}/log/sync_#{Rails.env}.log"
  config.lograge.formatter = Lograge::Formatters::Json.new

  config.lograge.ignore_custom = lambda do |event|
    # return true here if you want to ignore based on the event         
    return false if event.payload[:controller].include?("SyncController") && 
     ['index', 'create'].include?(event.payload[:action])
    return true
  end

  config.lograge.custom_payload do |controller|
    if controller.class.name.include?('SyncController')
      SyncLogger.new(controller).log_data
    end
  end

end
