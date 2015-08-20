require 'rails_helper'

describe History, type: :model do

  it 'should represent right data types for different values' do
    history = History.new('1122334455', '2014-09-05 21:29:30 UTC', 'passed', '543')
    expect(history.session_id).to be_kind_of(Integer)
    expect(history.created_at).to be_a(String)
    expect(history.status).to be_a(String)
    expect(history.duration).to be_a(Float)
  end

end