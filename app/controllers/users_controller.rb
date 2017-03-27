class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
		@post = Post.all
		@users = User.all
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy

	if @user.destroy
		redirect_to "/", notice: "User successfully deleted!"
		
		end
	end
	
end
