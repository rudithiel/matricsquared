Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'pages#home'
  
  get '/about', to: 'pages#about', as: 'about'
  get 'edit_subjects', to: 'subjects#edit', as: 'edit_subjects'
  post 'subject/:code/add', to: 'subjects#add', as: 'add_subject'
  post 'subject/:code/remove', to: 'subjects#remove', as: 'remove_subject'
  get 'subject/:code', to: 'subjects#show', as: 'show_subject'
  get 'faq', to: 'pages#faq', as: 'faq'
  get 'users', to: 'admins#users', as: 'users'
  
  #ADMIN ONLY ROUTES
  get 'admin/new_question', to: 'admins#new_question', as: 'new_question'
  post 'admin/add_question', to: 'admins#add_question', as: 'add_question'
  get 'admin/new_subject', to: 'admins#new_subject', as: 'new_subject'
  post 'admin/add_subject', to: 'admins#add_subject', as: 'add_new_subject'
  get 'admin/new_category', to: 'admins#new_category', as: 'new_category'
  post 'admin/add_category', to: 'admins#add_category', as: 'add_category'
  
  get 'admin/subjects', to: 'admins#subjects', as: 'subjects'
  
  get 'admin/subject/:id/categories', to: 'admins#subject_categories', as: 'subject_categories'
  get 'admin/subject/:id/questions', to: 'admins#subject_questions', as: 'subject_questions'
  get 'admin/category/:id/questions', to: 'admins#category_questions', as: 'category_questions'
  
  post 'admin/category/:id/destroy', to: 'admins#destroy_category', as: 'destroy_category'
  post 'admin/question/:id/destroy', to: 'admins#destroy_category_question', as: 'destroy_category_question'
  post 'admin/question/:id/destroy', to: 'admins#destroy_subject_question', as: 'destroy_subject_question'
  
  get 'admin/getcategories/:id', to: 'admins#getcategories', as: 'get_categories'
  
end
