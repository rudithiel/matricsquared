class UsersController < ApplicationController
  
  def show
    @user = User.where(username: params[:username]).first
    @starred_questions = @user.viewed_questions.where(starred: true).paginate(:page => params[:page], :per_page => 3)
    render :show
  end
  
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
