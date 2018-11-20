class PostsController < ApplicationController

	def index
		@sections 	= Section.order(:position)

		@articles 	= Article.ordered

		#@contacts 	= Contact.published

	end

end