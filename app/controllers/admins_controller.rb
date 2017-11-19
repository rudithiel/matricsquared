class AdminsController < ApplicationController
  before_filter :authorized?
  @@query_questions = nil
  
  def users
    @users = User.all
    render :users
  end  
  
  def home
  end
  
  def subjects
    @subjects = Subject.all
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
    @questions = @subject.questions.paginate(:page => params[:page], :per_page => 6)
  end
  
  def category_questions
    @category = Category.find(params[:id])
    @questions = @category.questions.paginate(:page => params[:page], :per_page => 6)
  end
  
  def query_questions
    if @@query_questions.nil? == false
      @questions = @@query_questions
    end
    render :query_questions
  end
  
  def perform_query
    if params.has_key?(:string)
      @@query_questions = Question.where("question LIKE '%#{params[:string]}%'").paginate(:page => params[:page], :per_page => 5)
    end
    redirect_to questions_query_path()
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
end
