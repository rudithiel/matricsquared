class QuestionsController < ApplicationController
  
  before_filter :set_category_questions, only: [:category_practice]
  before_filter :authorized?, only: [:new, :create, :edit, :update]
  
  def new
    @question = Question.new
    render :new
  end
  
  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:success] = "New question added to the database"
      redirect_to admin_portal_path
    else
      render :new
    end
  end
  
  def edit
    @question = Question.find(params[:id])
    render :edit
  end
  
  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "Successfully updated question"
      redirect_to admin_portal_path
    else
      render :edit
    end
  end
  
  def category_practice
    @question = @@questions.find(@@question_ids[0])
    render :practice
  end
  
  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:success] = "Deleted question"
    redirect_to admin_portal_path
  end
  
  def next_question
    @subject = Subject.find(Question.find(@@question_ids[0]).subject_id)
    @@question_ids.shift
    if @@question_ids.length != 0
      @question = @@questions.find(@@question_ids[0])
    end
    render :practice
  end
  
  def subject_practice
    @questions = Subject.find(params[:id]).questions
    @questions.shuffle!
    render :practice
  end
  
  private
    
    def set_category_questions
      @@category = Category.find(params[:id])
      @@questions = @@category.questions
      @@question_ids = []
      @@questions.each do |q|
        @@question_ids.push(q.id)
      end
      @@question_ids.shuffle!
    end
  
    def question_params
      params.require(:question).permit(:question, :option1, :option2, 
      :option3, :option4, :answer, :category_id, :subject_id, :diagram, :hasdiagram)
    end
    
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
end
