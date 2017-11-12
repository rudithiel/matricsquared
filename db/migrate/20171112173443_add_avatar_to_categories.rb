class AddAvatarToCategories < ActiveRecord::Migration
  def up
    add_attachment :categories, :avatar
  end
  
  def down
    remove_attachment :categories, :avatar
  end
end
