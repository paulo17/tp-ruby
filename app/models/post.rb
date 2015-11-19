class Post < ActiveRecord::Base
  belongs_to :user
  has_many :photos

  validates :user, presence: true

  before_save { |post| post.title = post.title.capitalize unless post.title.nil? }

  scope :published, -> { where(published: true) }

  def length
    return nil if self.message == ''
    self.message.size
  end

  def unpublish!
    self.published = false
  end

  def self.unpublish_all
    self.all.each do |post|
      post.unpublish!
      post.save!
    end
  end

end
