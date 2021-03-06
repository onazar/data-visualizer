require 'rails_helper'

describe Api::V1::HistoryController, type: :controller do

  render_views

  describe '#index' do
    before do
      xhr :get, :index
    end

    context 'allow unauthorized access' do
      it 'should respond with 200' do
        expect(response.status).to eq(200)
      end
    end

    context 'there should be data source' do
      # it 'there should be "session_history.csv" file under "data" directory' do
      #   expect(File.file?(Rails.root.join('data', 'session_history.csv'))).to eq(true)
      # end

      it 'should respond with 500 when file not found' do
        History::CSV_FILE = Rails.root.join('data', 'missing_file.csv')
        xhr :get, :index
        expect(response.status).to eq(500)
        History::CSV_FILE = Rails.root.join('data', 'session_history.csv')
      end
    end
  end

end