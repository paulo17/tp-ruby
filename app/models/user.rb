class User < ActiveRecord::Base
  validates :name, presence: { message: "Name can't be blank" }
  validates :email, format: { with: /\w*@\w*\.\w*/, message: 'Email is invalid' }, uniqueness: true, presence: true

  has_many :posts
  has_many :comments

  has_many :commented_posts, through: :comments, source: :post

  def self.export(format:)
    if format == :json
      User.all.inject([]) do |res, u|
        res << { id: u.id, name: u.name, email: u.email }
      end.to_json
    else
      raise ArgumentError
    end
  end
end
