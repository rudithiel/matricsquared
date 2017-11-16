class CreateViewedQuestions < ActiveRecord::Migration
  def change
    create_table :viewed_questions do |t|
      t.timestamps null: false
      t.belongs_to :user
      t.belongs_to :question
      t.boolean :starred
      t.boolean :answered_correctly
    end
  end
end
