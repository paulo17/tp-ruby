class Photo < ActiveRecord::Base
  belongs_to :post
  belongs_to :user

  validates :url, presence: true

  def file
      self.url.rpartition('/').last
  end

  def extension
    File.extname(self.file).tr('.', '')
  end

  def file_format
    if valid_extension?
      return extension
    else
      return nil
    end
  end

  def self.all_urls
    all_urls = []
    Photo.all.each do |photo|
      all_urls << photo.url
    end
    return all_urls
  end

  private
  def valid_extension?
    %w( jpg jpeg gif png pdf mp4 docx doc ).include? extension.downcase
  end
end
