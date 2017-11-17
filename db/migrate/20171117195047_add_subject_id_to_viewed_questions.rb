class AddSubjectIdToViewedQuestions < ActiveRecord::Migration
  def change
    add_column :viewed_questions, :subject_id, :integer
  end
end
