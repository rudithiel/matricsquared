class AdminsController < ApplicationController
  before_filter :authorized?
  
  def users
    @users = User.all
    respond_to do |format|
      format.html { render 'users' }
    end
  end  
  
  def home
  end
  
  def new_category
    @category = Category.new
    render :new_category
  end
  
  def add_category
    @category = Category.new(category_params)
    if @category.save
      redirect_to root_path
      flash[:success] = "Category #{@category.name} created for #{Subject.find(@category.subject_id).name}"
    else
      render :new_category
    end
  end
  
  def new_question
    @question = Question.new
    respond_to do |format|
      format.html { render 'new_question' }
    end
  end
  
  def add_question
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "New question added to the database"
      redirect_to root_path
    else
      render :new_question
    end
  end
  
  def subjects
    @subjects = Subject.all
  end
    
  def new_subject
    @subject = Subject.new
    respond_to do |format|
      format.html { render 'new_subject' }
    end
  end
  
  def add_subject
    @subject = Subject.new(subject_params)
    if @subject.save
      redirect_to root_path
    else
      render :new_subject
    end
  end
  
  def getcategories
    @subject = Subject.find(params[:id])
    respond_to do |format|
      format.json { render json: @subject.categories }
    end
  end
  
  def subject_categories
    @subject = Subject.find(params[:id])
    @categories = @subject.categories
  end
  
  def subject_questions
    @subject = Subject.find(params[:id])
    @questions = @subject.questions
  end
  
  def category_questions
    @category = Category.find(params[:id])
    @questions = @category.questions
  end
  
  def destroy_category
    @category = Category.find(params[:id])
    @subject = Subject.find(@category.subject_id)
    @category.destroy
    redirect_to subject_categories_path(@subject)
  end
  
  def destroy_category_question
    @question = Question.find(params[:id])
    @category = Category.find(@question.category_id)
    @question.destroy
    redirect_to category_questions_path(@category)
  end
  
  def destroy_subject_question
    @question = Question.find(params[:id])
    @subject = Subject.find(@question.subject_id)
    @question.destroy
    redirect_to subject_questions_path(@subject)
  end
  
  private
    
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
    
    def subject_params
      params.require(:subject).permit(:name, :code, :papers)
    end
    
    def category_params
      params.require(:category).permit(:name, :subject_id)
    end
    
    def question_params
      params.require(:question).permit(:question, :option1, :option2, 
      :option3, :option4, :answer, :category_id, :subject_id)
    end
end
