class RestaurantsController < ApplicationController
	include ActionView::Helpers::DateHelper

	def index

		# @restaurants = Restaurant.all
		# @update = Update.new
	end
	def new
		@lat = params['lat']
		@lon = params['lon']
		consumer_key = '4Tah-fX7PQPoEIeVdkQVbQ'
		consumer_secret = 'prvclJsNblTMvkS31NkjjJcFy7Q'
		token = 'TwVasnlt36KTr2L_srhHWvicIdPJhmri'
		token_secret = '29f6G9M6crMJPuvO4KarthWoorY'

		api_host = 'api.yelp.com'

		consumer = OAuth::Consumer.new(consumer_key, consumer_secret, {:site => "http://#{api_host}"})
		access_token = OAuth::AccessToken.new(consumer, token, token_secret)

		path = "/v2/search?term=restaurants&sort=1&ll=" + @lat +','+@lon

		@restaurants = access_token.get(path).body
		@businesses = JSON.parse(access_token.get(path).body)['businesses']
		@businesses.each do |restaurant|
			updates = Update.where(yelp_id: restaurant['id']).where('created_at >= ?', 10.minute.ago)
			if updates.any?
				statuses = updates.map{|i|i.status}
				average = (statuses.inject{ |sum, el| sum + el }.to_f / statuses.size).round

				# statuses1 = Update.where('created_at >= ?', 20.minute.ago).where('created_at <= ?', 11.minute.ago)
				# statuses1.map!{|i|i.status}
				# average1 = (statuses1.inject{ |sum, el| sum + el }.to_f / statuses1.size).round

				if average == 1
					wait = 'None'
				elsif average == 2
					wait = 'Short'
				elsif average == 3
					wait = 'Moderate'
				elsif average == 4
					wait = 'Long'
				end
				restaurant['wait_time'] = wait
				# puts restaurant['wait_time']
				# restaruant['last_updated'] = updates.last.created_at
				# puts '#################'
				# puts updates.last.created_at
				# puts '#################'
				time_elapsed = (Time.now - updates.last.created_at).to_i / 60
				if time_elapsed < 1 
					restaurant['last_updated'] = 'Last updated: Less than a minute ago'
				elsif time_elapsed == 1
					restaurant['last_updated'] = 'Last updated: 1 minute ago'
				else 
					restaurant['last_updated'] = 'Last updated: ' + time_elapsed.to_s + ' minutes ago'
				end
			else
				restaurant['wait_time'] = 'unknown'
				restaurant['last_updated'] = ''
			end
			# @average = average/updates.size
			
		end
		# puts average
		# updates = Update.find_by(yelp_id)

		respond_to do |format|
			format.html {redirect_to :back}
			format.json {render :json => {:restaurants => @businesses}}
		end
		# render text: @businesses
	end
end
