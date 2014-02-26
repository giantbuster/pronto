class Update < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  # validates :user_id, :uniqueness => {:scope => :restaurant_id}
end
