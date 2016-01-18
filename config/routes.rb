require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      resources :history, only: [:index]
    end
  end

  scope module: :public do
    get '*path', :to => 'index#index'
    root 'index#index'
  end

end
