class AddMasteryToUserSubjects < ActiveRecord::Migration
  def change
    add_column :user_subjects, :mastery, :integer
  end
end
