class SessionsController < ApplicationController
	def new
		@user.new
	end
	def show
		@current_user = session[:user_id]
	end
	def create
		user = User.find_by(email: params[:session][:email]).try(:authenticate, params[:session][:password])
		if user == false || user.nil?
	      redirect_to :back, flash: { message: "Incorrect email/password" }
	    else
	      sign_in(user)
	      redirect_to :restaurants
	    end
	end
	def destroy
		sign_out
		redirect_to :back
	end
end
