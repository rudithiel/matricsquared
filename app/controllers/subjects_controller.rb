class SubjectsController < ApplicationController
  before_filter :authorized?
  
  def show
    @subject = Subject.where(code: params[:code]).first
  end  
  
  def admin_show
    @subjects = Subject.all
  end
  
  def new
    @subject = Subject.new
    render :new
  end
  
  def create
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to admin_portal_path
    else
      render :new
    end
  end
  
  def edit
    @subject = Subject.find(params[:id])
    render :edit
  end
  
  def update
    @subject = Subject.find(params[:id])
    if @subject.update(subject_params)
      redirect_to admin_portal_path
    else
      render :edit
    end
  end
  
  def destroy
    @subject = Subject.find(params[:id])
    if @subject.destroy
      flash[:success] = "Successfully deleted the subject #{@subject.name}"
      redirect_to admin_portal_path
    else
      flash[:danger] = "Couldn't delete the requested subject"
      redirect_to admin_portal_path
    end
  end
  
  private
    def subject_params
      params.require(:subject).permit(:name, :code, :papers)
    end
    
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
  
end
