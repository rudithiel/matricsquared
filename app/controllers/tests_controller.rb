class TestsController < ApplicationController
  
  @@question_ids = []
  
  def test_paper
    @subject = Subject.find(params[:subject_id])
    @paper = params[:paper]
    @categories = Category.where(subject_id: @subject.id, paper: @paper)
    @categories.each do |category| 
      @questions = category.questions
      @q = @questions.shuffle
      $i = 1
      while $i < 2
        @@question_ids = @questions[$i].id
        @q.shift
        @q.shuffle
      end
    end
    
    render :test_paper
    
  end
  
  private
  
end
