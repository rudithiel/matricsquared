Rails.application.routes.draw do
  devise_for :users, :controllers => { sessions: 'users/sessions', registrations: 'users/registrations' }
  root to: 'pages#home'
  
  get 'about', to: 'pages#about', as: 'about'
  get 'edit_subjects', to: 'users#edit_subjects', as: 'edit_subjects'
  post 'subject/:code/add', to: 'users#add_subject', as: 'add_subject'
  post 'subject/:code/remove', to: 'users#remove_subject', as: 'remove_subject'
  get 'subject/:code', to: 'subjects#show', as: 'show_subject'
  get 'faq', to: 'pages#faq', as: 'faq'
  get 'privacy_policy', to: 'pages#privacy_policy', as: 'privacy_policy'
  
  get 'practice/category/:id', to: 'questions#category_practice', as: 'category_practice'
  get 'practice/subject/:code/:paper', to: 'questions#paper_practice', as: 'paper_practice'
  
  get '/practice/next', to: 'questions#next_question', as: 'next_question'
  
  #USERS
  get '/users/:username', to: 'users#show', as: 'user'
  
  #QUESTIONS
  post 'question/:id/star', to: 'questions#star', as: 'star_question'
  get 'question/:id', to: 'questions#show', as: 'show_question'
  post 'question/:id/answer/:answer', to: 'questions#answer', as: 'answer_question'
  get 'question/:id/details', to: 'questions#get_details', as: 'get_details'
  
  
  ##ADMIN ONLY ROUTES##
  get 'users', to: 'admins#users', as: 'users'
  get 'admin', to: 'admins#admin_portal', as: 'admin_portal'
  get 'questions/query', to: 'admins#query_questions', as: 'questions_query'
  post 'questions/query', to: 'admins#perform_query'
  
  #CREATE
  get 'admin/new_question', to: 'questions#new', as: 'new_question'
  post 'admin/add_question', to: 'questions#create', as: 'add_question'
  get 'admin/new_subject', to: 'subjects#new', as: 'new_subject'
  post 'admin/add_subject', to: 'subjects#create', as: 'add_new_subject'
  get 'admin/new_category', to: 'categories#new', as: 'new_category'
  post 'admin/add_category', to: 'categories#create', as: 'add_category'
  
  #UPDATE & EDIT
  get 'admin/category/:id/edit', to: 'categories#edit', as: 'edit_category'
  post 'admin/category/:id/edit', to: 'categories#update', as: 'update_category'
  get 'admin/subject/:id/edit', to: 'subjects#edit', as: 'edit_subject'
  post 'admin/subject/:id/edit', to: 'subjects#update', as: 'update_subject'
  get 'admin/question/:id/edit', to: 'questions#edit', as: 'edit_question'
  post 'admin/question/:id/edit', to: 'questions#update', as: 'update_question'
  
  
  #VIEWS
  get 'admin/subjects', to: 'subjects#admin_show', as: 'subjects'
  get 'admin/subject/:id/categories', to: 'admins#subject_categories', as: 'subject_categories'
  get 'admin/subject/:id/questions', to: 'admins#subject_questions', as: 'subject_questions'
  get 'admin/category/:id/questions', to: 'admins#category_questions', as: 'category_questions'
  
  #DESTROY
  post 'admin/category/:id/destroy', to: 'categories#destroy', as: 'destroy_category'
  post 'admin/question/:id/destroy', to: 'questions#destroy', as: 'destroy_category_question'
  post 'admin/subject/:id/destroy', to: 'subjects#destroy', as: 'destroy_subject'
  
  get 'admin/getcategories/:id', to: 'admins#getcategories', as: 'get_categories'
  
end
