class Admin::ServicesController < Admin::ApplicationController
  before_action :set_admin_service, only: [:show, :edit, :update, :destroy]

 
  def index
    @services = Service.order(id: :asc)
 
  end

  def show
  end

  def new
    @service = Service.new
  end

  def edit
  end

  def create
    @service = Service.new(service_params)

    respond_to do |format|
      if @service.save
        format.html { redirect_to admin_services_url(:cat => @service.section_id), notice: 'Tjeneste er lagt til.' }
        format.json { render :show, status: :created, location: @service }
      else
        format.html { render :new }
        format.json { render json: @service.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @service.update(service_params)
        format.html { redirect_to admin_services_url(:cat => @service.section_id), notice: 'Tjenesten ble oppdatert.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @service.destroy
    respond_to do |format|
      format.html { redirect_to admin_services_url(:cat => @service.section_id), notice: 'Tjenesten ble slettet.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_service
      @service = Service.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_params
      params.require(:service).permit(:title, :description, :icon, :ispublished, :section_id)
    end
end
