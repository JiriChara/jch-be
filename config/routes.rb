Rails.application.routes.draw do
  resources :articles

  resources :projects

  resources :tags, only: [
    :index
  ]

  resources :images, only: [
    :index,
    :create,
    :destroy
  ]

  resources :users, only: [
    :index,
    :show,
    :create
  ]

  resources :tokens, only: [
    :create
  ]
end
