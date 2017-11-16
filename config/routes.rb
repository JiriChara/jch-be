Rails.application.routes.draw do
  resources :articles, param: :slug, only: [
    :index,
    :show
  ]
  resources :projects, param: :slug

  resources :tags, param: :slug, only: [
    :index
  ]
end
