class QuestionsController < ApplicationController
  def category_practice
    @questions = Category.find(params[:id]).questions
    render :practice
  end
end
