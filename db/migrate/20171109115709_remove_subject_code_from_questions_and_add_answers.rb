class RemoveSubjectCodeFromQuestionsAndAddAnswers < ActiveRecord::Migration
  def change
    remove_column :questions, :subject_code
    add_column :questions, :paper, :string
    add_column :questions, :option1, :string
    add_column :questions, :option2, :string
    add_column :questions, :option3, :string
    add_column :questions, :option4, :string
  end
end
