Rails.application.routes.draw do
  devise_for :users
root 'welcome#home'
get '/about', to:'welcome#about'
get '/contact', to:'welcome#contact'
end
