class User < ActiveRecord::Base
  has_many :posts
  has_many :comments

  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true

  def self.export(format: :json)
    return User.select(:id, :name, :email).to_json if format.equal? :json
    raise ArgumentError if format.equal? :xml
  end

  def commented_posts
    commented_posts = []
    self.comments.each do |comment|
      commented_posts << comment.post unless commented_posts.include? comment.post
    end
    return commented_posts
  end

end