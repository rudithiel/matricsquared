class Category < ActiveRecord::Base
  paperclip_opts = {
  :styles => { :thumb => '40x40#', :medium => '150x200>', :large => '300x300>' },
  :convert_options => { :all => '-quality 92' },
  :processor       => [ :cropper ]
  }
  
  unless Rails.env.development?
    paperclip_opts.merge! :storage        => :s3,
                          :s3_region => ENV['AWS_REGION'], 
                          :s3_credentials => {
                            :bucket => ENV['AWS_BUCKET_NAME'],
                            :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
                            :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
                          },
                          :bucket         => ENV['AWS_BUCKET_NAME']
  end
  
  belongs_to :subject
  has_many :questions
  attr_accessor :subject_name
  has_attached_file :avatar, paperclip_opts
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png"]
  validates :subject_id, presence: true, numericality: true
  validates :name, presence: true, uniqueness: true
end
