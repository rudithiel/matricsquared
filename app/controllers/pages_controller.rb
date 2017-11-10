class PagesController < ApplicationController
 
  def home
    if  user_signed_in? && current_user.admin?
      render 'admins/home'
    else
      render 'home'
    end
  end
  
  def about
    render 'about'
  end
  
end
