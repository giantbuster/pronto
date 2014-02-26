class Restaurant < ActiveRecord::Base
	has_many :updates
	# has_many :updaters, through: :updates, source: :user
end
