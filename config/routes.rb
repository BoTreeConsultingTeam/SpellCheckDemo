Rails.application.routes.draw do
  root 'homes#index'
  post 'homes/get_suggestion', 'homes#get_suggestion'
end
