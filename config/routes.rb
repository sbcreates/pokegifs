Rails.application.routes.draw do

  resources :pokemon, only: [:index, :show]

end
