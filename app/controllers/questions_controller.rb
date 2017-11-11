class QuestionsController < ApplicationController
  
  before_filter :set_category_questions, only: [:category_practice]
  
  def category_practice
    @question = @@questions.find(@@question_ids[0])
    render :practice
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
  
end
