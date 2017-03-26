Rails.application.routes.draw do
  root 'scans#index'
  resources :scans
end
