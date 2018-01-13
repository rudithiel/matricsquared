class RemoveForums < ActiveRecord::Migration
  def change
    drop_table :forum_questions
    drop_table :forum_answers
  end
end
