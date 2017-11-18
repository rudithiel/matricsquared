class AddDescriptionToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :description, :string, :default => ""
  end
end
