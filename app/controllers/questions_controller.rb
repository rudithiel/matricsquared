class QuestionsController < ApplicationController
  
  before_filter :set_category_questions, only: [:category_practice]
  before_filter :set_paper_questions, only: [:paper_practice]
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
  
  def get_details
    @question = Question.find(params[:id])
    details = {answer: @question.answer}
    respond_to do |format|
      format.json {render json: details}
    end
  end
  
  def answer
    @answer = params[:answer]
    @question = Question.find(params[:id])
    set_viewed_question(@question.id)
    if @question.answer == @answer 
      @viewed_question.update(answered_correctly: true)
    else
      @viewed_question.update(answered_correctly: false)
    end
    update_user_subject_mastery(@question.subject_id)
    respond_to do |format|
      format.html {render nothing: true}
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
    @question = Question.find(@@question_ids[0])
    set_viewed_question(@question.id)
    render :practice
  end
  
  def paper_practice
    @question = Question.find(@@question_ids[0])
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
      @question = Question.find(@@question_ids[0])
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
  
    def update_user_subject_mastery(subject_id)
      @subject = Subject.find(subject_id)
      @user = current_user
      @user_subject = UserSubject.where(user_id: @user.id, subject_id: @subject.id).first
      @total_questions = @subject.questions.count
      @correct_questions = @user.viewed_questions.where(answered_correctly: true, subject_id: @subject.id).count
      @mastery = ((@correct_questions.to_f / @total_questions.to_f) * 100).round
      @user_subject.update(mastery: @mastery)
    end
  
    def set_viewed_question(question_id)
      @viewed_question = ViewedQuestion.where(question_id: question_id, user_id: current_user.id).first
      unless ViewedQuestion.exists?(question_id: question_id, user_id: current_user.id)
        @viewed_question = ViewedQuestion.create(subject_id: @question.subject_id, question_id: @question.id, user_id: current_user.id, starred: false, answered_correctly: false)
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
    
    def set_paper_questions
      @subject = Subject.where(code: params[:code]).first
      @@categories = Category.where(subject_id: @subject.id, paper: params[:paper])
      @@question_ids = []
      @@categories.each do |c|
        c.questions.each do |q|
          @@question_ids.push(q.id)
        end
      end
      @@question_ids.shuffle!
    end
  
    def question_params
      params.require(:question).permit(:question, :option1, :option2, :option3, :option4, :answer, 
      :category_id, :subject_id, :diagram, :memo, :hasdiagram, :description)
    end
    
    def authorized?
      unless user_signed_in? && current_user.admin?
        redirect_to root_path
      end
    end
end
