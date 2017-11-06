Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations' }
  get '/about', to: 'pages#about', as: 'about'
  root to: 'pages#home'
  get '/' => 'pages#home'
  get 'edit_subjects', to: 'subjects#edit', as: 'edit_subjects'
  post 'edit_subjects', to: "subjects#update", as: "update_subjects"
end
