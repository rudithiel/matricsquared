class RemoveHasdiagramFromQuestions < ActiveRecord::Migration
  def change
    remove_column :questions, :hasdiagram
  end
end
