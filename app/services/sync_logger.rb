class SyncLogger
  def initialize(controller)
    @controller = controller
  end
  
  def log_data
    request_type = @controller.request.method
    username = @controller.current_user.try(:username) || 'guest'
    r_data = request_type == 'GET' ? JSON.parse(@controller.response.body) : @controller.request.parameters
    log_data = {
      u_agent: @controller.request.user_agent,
      request_time: Time.now.to_s(:number),
      search_key: "#{request_type}_#{username}_#{Time.zone.now.to_s(:number)}",
      ip: @controller.request.ip,
      user_id: @controller.current_user.try(:id),
      username: username,
      data: r_data
    }
  end
end
