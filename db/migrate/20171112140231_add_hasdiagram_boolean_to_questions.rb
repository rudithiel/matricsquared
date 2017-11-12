class AddHasdiagramBooleanToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :hasdiagram, :boolean, :default => :false
  end
end
