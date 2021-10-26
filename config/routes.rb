Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about' ,as: 'about'
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, onlu: [:index,:show,:create,:edit,:update,:destroy] do
  resources :book_comments, only: [:create, :destroy]
  resource  :favorites, only: [:create, :destroy]
  end
# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end 