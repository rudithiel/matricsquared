class Subject < ActiveRecord::Base
  has_many :user_subjects
  has_many :categories
  has_many :questions
  has_many :forum_questions
  has_many :users, through: :user_subjects
  has_attached_file :banner
  has_attached_file :avatar
  validates_attachment_content_type :banner, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates_presence_of :name
  validates_presence_of :papers
  validates_presence_of :theme
  validates :code, presence: true, uniqueness: true, length: {is: 4}
end
