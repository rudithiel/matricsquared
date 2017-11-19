class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :user_subjects
  has_many :viewed_questions
  has_many :subjects, through: :user_subjects 
  validates :province, presence: true
  validates :username, presence: true, uniqueness: true, length: {minimum: 3}
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
