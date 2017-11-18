class AddThemeColorToSubjects < ActiveRecord::Migration
  def change
    add_column :subjects, :theme, :string, :default => "success"
  end
end
