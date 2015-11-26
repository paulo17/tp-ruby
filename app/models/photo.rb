class Photo < ActiveRecord::Base
  belongs_to :post
  validates :url, format: { with: /http:\/\/[\w]*\.[\w]*\/[\w]*\.(jpg|gif)/ }

  def self.all_urls
    select(:url).map(&:url)
  end

  def file
    return nil unless valid?
    url.split("/").last
  end

  def file_format
    return nil unless valid?
    file.split(".").last
  end
end
