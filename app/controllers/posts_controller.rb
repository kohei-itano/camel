class PostsController < ApplicationController

	def index
		@posts = Post.all

	end

	def show
		@post = Post.find(params[:id])
		@user = @post.user
	end

	def edit

	end

	def new
		@post = Post.new
	end

	def create
		@post = Post.new(post_params)
		@post.user_id = current_user.id
		if @post.save
			 redirect_to user_path(current_user.id)
		else
			flash[:notice] = "error"
			redirect_to new_post_path
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :body, :post_image)
	end

end

