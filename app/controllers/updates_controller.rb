class UpdatesController < ApplicationController
	def index
		# @update = Update.new
	end	
	def create
		if signed_in?
		# if Restaurant.where(id: params[:restaurant_id]).any?
			Update.create(user_id: session[:user_id], yelp_id: params[:yelp_id], status: params[:status])
			# render text: params
	   		redirect_to :back
	   	# else
	   		# Restaurant.create(name: )
	   	# end
	   	# redirect_to :back
	   else
	   	redirect_to :new_user
	   end

	end
private
	# def update_params
	# 	params.require(:update).permit(:user_id, :restaurant_id, :status)
	# end

end
