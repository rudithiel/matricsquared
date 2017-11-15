class AddMemoToQuestions < ActiveRecord::Migration
  def up
    add_attachment :questions, :memo
  end
  
  def down
    remove_attachment :questions, :memo
  end
end
