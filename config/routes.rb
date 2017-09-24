Rails.application.routes.draw do
  resources :resumes, only: [:create]
  root 'root#index'
end
