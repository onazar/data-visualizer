require 'rails_helper'

describe 'routes to the root path', type: :routing do
  it 'should route to public/index#index' do
    expect(get: root_path).to route_to(controller: 'public/index', action: 'index')
  end
end