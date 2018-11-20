class Admin::ModeratorsController < Admin::ApplicationController

	def index
		@moderators = Moderator.all
	end

	def new
    	@moderator = Moderator.new
    end

	def edit
		@moderator = Moderator.find(params[:id])
	end

	def create
    	@moderator = Moderator.new(moderator_params)
    	respond_to do |format|
      		if @moderator.save
        		format.html { redirect_to admin_moderators_url, notice: 'Administrator' + moderator_params[:fullname] + 'ble opprettet.' }
        		format.json { render :show, status: :created, location: @moderator }
      		else
       			format.html { render :new }
        		format.json { render json: @moderator.errors, status: :unprocessable_entity }
      		end
    	end
  	end

	def update
		@moderator = Moderator.find(params[:id])

		if 	@moderator.update(moderator_params)
			flash[:notice] = "Moderator was successfully updated."
			redirect_to admin_moderators_url
		else
			flash[:alert] = "There was a problem updating Moderator."
			render 'edit'
		end

	end

	private
		def moderator_params
			params.require(:moderator).permit(:id, :fullname, :username, :password)
		end
end