class CategoriesController < ApplicationController
  before_filter :authorized?
  
  def new
    @category = Category.new
    render :new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_portal_path
      flash[:success] = "Category #{@category.name} created for #{Subject.find(@category.subject_id).name}"
    else
      render :new
    end
  end
  
  def edit
    @category = Category.find(params[:id])
    render :edit
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      redirect_to admin_portal_path
      flash[:success] = "Category #{@category.name} was edited successfully"
    else
      render :edit
    end  
  end
  
  def destroy
    @category = Category.find(params[:id])
    @subject = Subject.find(@category.subject_id)
    @category.destroy
    redirect_to subject_categories_path(@subject)
  end
  
  private
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
    
    def category_params
      params.require(:category).permit(:name, :subject_id, :avatar, :paper)
    end
end
