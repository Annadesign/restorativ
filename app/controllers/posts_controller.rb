class PostsController < ApplicationController

	def index
		@sections 	= Section.order(:position)

		@articles 	= Article.ordered

		@facts = Article.facts

		#@contacts 	= Contact.published

	end

end