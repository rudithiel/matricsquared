class AddBannerAndAvatarToSubjects < ActiveRecord::Migration
  def up
    add_attachment :subjects, :banner
    add_attachment :subjects, :avatar
  end
  
  def down
    remove_attachment :subjects, :banner
    remove_attachment :subject, :avatar
  end
end
