require 'csv'
class Api::HistoryController < ApplicationController

  CSV_FILE = Rails.root.join('data', 'session_history.csv')

  def index
    @data_rows = []
    CSV.foreach(CSV_FILE, headers: true) do |row|
      @data_rows << History.new(row['session_id'], row['created_at'], row['summary_status'], row['duration'])
    end
    rescue Errno::ENOENT
      render nothing: true, status: 500
  end

end