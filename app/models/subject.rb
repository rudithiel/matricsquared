class Subject < ActiveRecord::Base
  has_many :user_subjects
  has_many :users, through: :user_subjects
  validates :name, presence: true
  validates :papers, presence: true
end
