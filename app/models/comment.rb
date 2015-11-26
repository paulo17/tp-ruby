class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def formatted_message(shout:false)
    "#{user.name} said: #{shout ? message.upcase : message}"
  end
end
