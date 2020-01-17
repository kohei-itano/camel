class SearchesController < ApplicationController

	def search
		@posts = Post.search(params[:search])
	end
end
