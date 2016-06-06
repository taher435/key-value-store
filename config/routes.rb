Rails.application.routes.draw do


  root 'application#default_action'

  get 'store/:key' => 'store#get'


  resources :store
end
