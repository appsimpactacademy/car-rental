Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations'
  }
  devise_scope :user do
    post '/login_with_phone_number', to: 'users/sessions#login_with_phone_number', as: :login_with_phone_number
    get '/otp_page', to: 'users/sessions#otp_page', as: :otp_page
    post '/verify_otp', to: 'users/sessions#verify_otp', as: :verify_otp
  end
end
