class UserController < ApplicationController
	def create
		user = User.new
		user.name = params[:username]
		if not user.save
			redirect_to :back
		end
	end

	def show
		@user = User.find(params[:id])
		@games = @user.games.order(created_at: :desc)
	end

private
	def user_params
		params(:user).permit(:username)
	end	
end
