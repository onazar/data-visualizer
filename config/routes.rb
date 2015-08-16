Rails.application.routes.draw do

  scope :api, module: :api, defaults: {format: :json} do
    resources :history, only: [:index]
  end

  scope :module => :public do
    root 'index#index'
    get '*path', :to => 'index#index'
  end

end
