Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  root 'scans#index'
  resources :scans
end
