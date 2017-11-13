class AddPaperToCategoriesAndRemoveFromQuestions < ActiveRecord::Migration
  def change
    add_column :categories, :paper, :integer
    remove_column :questions, :paper
  end
end
