class Subject < ActiveRecord::Base
  has_many :user_subjects
  has_many :categories
  has_many :questions
  has_many :users, through: :user_subjects
  validates :name, presence: true
  validates :papers, presence: true
  validates :code, presence: true, uniqueness: true, length: {is: 4}
end
