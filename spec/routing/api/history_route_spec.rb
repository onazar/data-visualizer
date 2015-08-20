require 'rails_helper'

describe 'routes to the history path', type: :routing do
  it 'should route to api/history#index' do
    expect(get: history_index_path).to route_to(controller: 'api/history', action: 'index', format: :json)
  end
end