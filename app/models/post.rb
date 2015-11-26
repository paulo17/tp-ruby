class Post < ActiveRecord::Base
  default_scope { where(published: true) }
  belongs_to :user
  has_many :comments
  has_many :photos

  validates :user_id, presence: true
  scope :published, -> { where(published: true) }

  before_create :upcase_title

  def upcase_title
    if title
      self.title =  title.slice(0,1).capitalize + title.slice(1..-1)
    end
  end

  def length
    message.blank? ? nil : message.size
  end

  def unpublish!
    self.update_attribute(:published, false)
  end

  def self.unpublish_all
    update_all(published: false)
  end
end
