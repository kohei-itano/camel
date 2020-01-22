class UsersController < ApplicationController
	before_action :authenticate_user!, except: [:edit, :update, :destroy]

	def index
		@users = User.page(params[:page]).reverse_order
	end

	def show
		@user = User.find(params[:id])
	end

	def edit
		@user = User.find(params[:id])
		@genres = Genre.all
		if current_user == @user
		else
			flash[:notice] = "エラー"
			redirect_to user_path(current_user.id)
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "ユーザー情報変更しました"
			redirect_to user_path(@user)
		else
			flash[:notice] = "エラー"
			render action: :edit
		end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	def followers
		user = User.find(params[:id])
		@users = user.followers
	end

	def follows
		user = User.find(params[:id])
		@users = user.followings
	end

	private
	def user_params
		params.require(:user).permit(:profile_image, :name, :introduction)
	end
end