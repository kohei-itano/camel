class UsersController < ApplicationController

	def index

	end

	def show
		@user = User.find(params[:id])

	end

	def edit

	end

	def followers

	end

	def follows

	end

end
