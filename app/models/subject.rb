class Subject < ActiveRecord::Base
  has_many :user_subjects
  has_many :categories
  has_many :questions
  has_many :users, through: :user_subjects
  has_attached_file :banner, default_url: "/images/default_banner"
  has_attached_file :avatar, default_url: "/images/default_avatar"
  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates :name, presence: true
  validates :papers, presence: true
  validates :code, presence: true, uniqueness: true, length: {is: 4}
end
