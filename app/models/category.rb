class Category < ActiveRecord::Base
  belongs_to :subject
  has_many :questions
  attr_accessor :subject_name
  validates :subject_id, presence: true, numericality: true
  validates :name, presence: true, uniqueness: true
end
