class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :subject_code
      t.string :category
      t.string :answer
      t.timestamps null: false
    end
  end
end
