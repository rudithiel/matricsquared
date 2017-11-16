class QuestionsController < ApplicationController
  
  before_filter :set_category_questions, only: [:category_practice]
  before_filter :authorized?, only: [:new, :create, :edit, :update]
  
  def show
    @question = Question.find(params[:id])
    set_viewed_question(@question.id)
    render :show
  end
  
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
  
  def star
    set_viewed_question(params[:id])
    if @viewed_question.starred?
      @viewed_question.starred = false
    else
      @viewed_question.starred = true
    end
    @viewed_question.save
    respond_to do |format|
      format.html {render nothing: true}
    end
  end
  
  def category_practice
    @question = @@questions.find(@@question_ids[0])
    set_viewed_question(@question.id)
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
      set_viewed_question(@question.id)
    end
    render :practice
  end
  
  def subject_practice
    @questions = Subject.find(params[:id]).questions
    @questions.shuffle!
    render :practice
  end
  
  private
  
    def set_viewed_question(question_id)
      @viewed_question = ViewedQuestion.where(question_id: question_id, user_id: current_user.id).first
      unless ViewedQuestion.exists?(question_id: question_id, user_id: current_user.id)
        @viewed_question = ViewedQuestion.create(question_id: @question.id, user_id: current_user.id, starred: false, answered_correctly: false)
      end  
    end
    
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
      :option3, :option4, :answer, :category_id, :subject_id, :diagram, :memo, :hasdiagram)
    end
    
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
end
