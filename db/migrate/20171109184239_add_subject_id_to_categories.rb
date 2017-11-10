class AddSubjectIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :subject_id, :integer
  end
end
