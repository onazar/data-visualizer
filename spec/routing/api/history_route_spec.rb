require 'rails_helper'

describe 'routes to the history api', type: :routing do
  describe 'route to default api version' do
    it 'should route to api/v1/history#index' do
      expect(get: api_history_index_path).to route_to(controller: 'api/v1/history', action: 'index', format: :json)
    end
  end
end