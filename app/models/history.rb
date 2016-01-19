require 'csv'

class History

  attr_accessor :session_id, :created_at, :status, :duration

  CSV_FILE = Rails.root.join('data', 'session_history.csv')

  alias :read_attribute_for_serialization :send

  def initialize(attributes = {})
    @session_id = attributes[:session_id].to_i if attributes[:session_id]
    @created_at = attributes[:created_at].to_s if attributes[:created_at]
    @status = attributes[:status].to_s if attributes[:status]
    @duration = attributes[:duration].to_f if attributes[:duration]
  end

  def self.read
    history = []
    CSV.foreach(CSV_FILE, headers: true) do |row|
      history << self.new(session_id: row['session_id'],
                          created_at: row['created_at'],
                          status: row['summary_status'],
                          duration: row['duration'])
    end
    return history
    rescue Errno::ENOENT
      return nil
  end

end
