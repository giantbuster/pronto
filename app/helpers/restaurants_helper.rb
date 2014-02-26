module RestaurantsHelper
	def update_form(restaurantId)
		# <!-- if signed_in? -->
			form_tag(updates_path, method: :post, authenticity_token: true) do
				hidden_field_tag("user_id", current_user.id) +
				hidden_field_tag("restaurant_id", restaurantId) +
				label_tag('none')+
				radio_button_tag('status', 1) + 
				label_tag('short')+
				radio_button_tag('status', 2) + 
				label_tag('moderate')+
				radio_button_tag('status', 3) + 
				label_tag('long')+
				radio_button_tag('status', 4) + 
				button_tag(:comment)
			end
		# end -->
	end
end
