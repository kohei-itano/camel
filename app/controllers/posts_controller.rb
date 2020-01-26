class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		if params[:genre_id]
			@posts = Post.where(genre_id: params[:genre_id]).page(params[:page]).reverse_order
		else
			@posts = Post.page(params[:page]).reverse_order
		end
	end

	def show
		@post = Post.find(params[:id])
		@user = @post.user
		@post_comment = PostComment.new
	end

	def edit
		@post = Post.find(params[:id])
		if current_user.id == @post.user_id
		else
			redirect_to posts_path
		end
	end

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to user_path(current_user.id)
	end

	def update
		@post = Post.find(params[:id])
		if @post.update(post_params)
			 flash[:notice] = "投稿情報変更しました"
			 redirect_to post_path(@post.id)
			else
				render action: :edit
		end
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
		params.require(:post).permit(:title, :body, :post_image, :genre_id)
	end

end

