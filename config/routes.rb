Contest4good::Application.routes.draw do
  devise_for :users,
             :controllers => {:sessions => "u/sessions", :invitations => "u/invitations"},
             :path => 'u',
             :path_names => {:sign_in => 'login', :sign_out => 'logout'},
             skip: [:registration, :password]

  namespace :u do
    resource :user_profile, :controller => "user_profiles", only: [:edit, :update, :show]
    get '/', to: 'home#index', as: 'home'
  end


  get "home/index"
  root :to => "home#index"
end
