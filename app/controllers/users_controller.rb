class UsersController < ApplicationController

	def index
		@users = User.all

	end

	def show
		@user = User.find(params[:id])

	end

	def edit
		@user = User.find(params[:id])
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

	end

	def follows

	end

	private
	def user_params
		params.require(:user).permit(:profile_image, :name, :introduction)
	end
end