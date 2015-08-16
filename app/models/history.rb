class History

  attr_accessor :session_id, :created_at, :status, :duration

  def initialize(session_id, created_at, status, duration)
    @session_id = session_id.to_i
    @created_at = created_at.to_s
    @status = status.to_s
    @duration = duration.to_f
  end

end
