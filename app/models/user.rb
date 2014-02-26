class User < ActiveRecord::Base
	has_many :updates
	has_many :updated_restaurants
	has_secure_password

	validates_presence_of :f_name, :l_name, :email
	validates_uniqueness_of :email

	def add_update(restaurant)
		Update.create(
			user_id: self.id,
			restaurant_id: restaurant.id
		)
	end

	# def update!(restaurant, status)
	# 	updates.create!(restaurant_id: restaurant.id, status: status)
	# end
end
