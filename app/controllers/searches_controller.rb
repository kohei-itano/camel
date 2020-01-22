class SearchesController < ApplicationController

	def search
		@posts = Post.search(params[:search]).page(params[:page]).reverse_order
	end
end
