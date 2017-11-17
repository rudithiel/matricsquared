class AddMasteryDefaultToUserSubjects < ActiveRecord::Migration
  def change
    change_column_default(:user_subjects, :mastery, 0)
  end
end
