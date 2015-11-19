class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post

  def formatted_message(shout: false)
    if shout
      "#{self.user.name} said: #{self.message.upcase}"
    else
      "#{self.user.name} said: #{self.message}"
    end
  end
end
