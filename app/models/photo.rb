class Photo < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :url, presence: true
  validate :validate_format

  def file
    valid_extension? ? url.split('/').last : nil
  end

  def extension
    File.extname(self.file).tr('.', '')
  end

  def file_format
    valid_extension? ? url.split('.').last : nil
  end

  def self.all_urls
    Photo.pluck(:url)
  end

  def validate_format
    errors.add(:url, 'Format error') unless valid_extension?
  end

  private
  def valid_extension?
    %w( jpg jpeg gif png pdf mp4 docx doc ).include? url.split('.').last
  end
end
