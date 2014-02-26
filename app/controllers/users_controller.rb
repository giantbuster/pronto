class UsersController < ApplicationController
	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)
	  	if @user.save
	  		sign_in(@user) 
	  		redirect_to :restaurants
	  	else
	  		redirect_to :back, flash: {errors: @user.errors.full_messages}
	  	end
	end

private
	def user_params
		params.require(:user).permit(:f_name, :l_name, :email, :password, :password_confirmation)
	end
end
