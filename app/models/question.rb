class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :category
  attr_accessor :subject_name
  validates :question, presence: true
  validates :category_id, presence: true
  validates :subject_id, presence: true
  validates :option1, presence: true
  validates :option2, presence: true
  validates :option3, presence: true
  validates :option4, presence: true
  validates :answer, presence: true
end
