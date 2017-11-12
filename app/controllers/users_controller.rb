class UsersController < ApplicationController
  def edit_subjects
    @subjects = Subject.all
    render :edit_subjects
  end  
  
  def remove_subject
    @subject = Subject.where(code: params[:code])
    current_user.subjects.delete(@subject)
    render :edit_subjects
  end
  
  def add_subject
   @subject = Subject.where(code: params[:code]) 
   current_user.subjects.push(@subject)
   render :edit_subjects
  end
  
end
