class UsersController < ApplicationController
	
	def projects
		@projects = current_user.projects if current_user
	end
	
	def index
		redirect_to projects_user_url(current_user), :notice => "Signed in!" if current_user
	end
end