require 'rails_helper'

describe History, type: :model do

  describe '.new' do
    it 'should represent right data types for different values' do
      history = History.new(session_id: '1122334455',
                            created_at: '2014-09-05 21:29:30 UTC',
                            status: 'passed',
                            duration: '543')
      expect(history.session_id).to be_kind_of(Integer)
      expect(history.created_at).to be_a(String)
      expect(history.status).to be_a(String)
      expect(history.duration).to be_a(Float)
    end
  end

  describe '.read' do
    it 'should have "session_history.csv" file under "data" directory' do
      expect(File.file?(Rails.root.join('data', 'session_history.csv'))).to eq(true)
    end

    it 'should return array of objects' do
      history = History.read
      expect(history).to be_instance_of Array
      expect(history.first).to be_instance_of History
    end
  end

end