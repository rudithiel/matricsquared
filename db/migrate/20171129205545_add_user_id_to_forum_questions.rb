class AddUserIdToForumQuestions < ActiveRecord::Migration
  def change
    add_column :forum_questions, :user_id, :integer
  end
end
