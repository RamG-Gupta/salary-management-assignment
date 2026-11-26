Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "dashboard#index"
  resources :employees, except: %i[new edit], defaults: { format: :json }
  get "insights", to: "insights#show", defaults: { format: :json }
end
