Rails.application.routes.draw do
  devise_for :users, sign_out_via: :delete
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: 'pages#home'
  resources :works
  get 'mypage', to: 'mypages#show', as: :mypage
  get 'profile/edit', to: 'profiles#edit', as: :edit_profile
  patch 'profile', to: 'profiles#update', as: :update_profile
  
  # メールアドレス変更
  get 'email_change/edit', to: 'email_changes#edit', as: :edit_email_change
  patch 'email_change', to: 'email_changes#update', as: :update_email_change
  
  # パスワード変更
  get 'password_change/edit', to: 'password_changes#edit', as: :edit_password_change
  patch 'password_change', to: 'password_changes#update', as: :update_password_change
  
  # メール送信テスト
  get 'test_mail', to: 'test_mails#new', as: :new_test_mail
  post 'test_mail', to: 'test_mails#create', as: :test_mails
  
  # Letter Opener（開発環境のみ）
  # Letter Opener Webは使用せず、シンプルなLetter Openerを使用
  
  get 'privacy_policy', to: 'pages#privacy_policy', as: :privacy_policy
  get 'terms_of_service', to: 'pages#terms_of_service', as: :terms_of_service
end
