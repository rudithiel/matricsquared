class Category < ActiveRecord::Base
  belongs_to :subject
  has_many :questions
  attr_accessor :subject_name
  has_attached_file :avatar, default_url: "/images/default_avatar"
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates :subject_id, presence: true, numericality: true
  validates :name, presence: true, uniqueness: true
end
