class AddDiagramsToQuestions < ActiveRecord::Migration
  def up
    add_attachment :questions, :diagram
  end

  def down
    remove_attachment :questions, :diagram
  end
end
