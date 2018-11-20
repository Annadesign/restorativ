class Admin::PartnersController < Admin::ApplicationController
  

  before_action :set_admin_partner, only: [:show, :edit, :update, :destroy]

 
  def index
    @partners = Partner.where(:section_id => params[:cat]).order(id: :asc)
 
  end

  def show
  end

  def new
    @partner = Partner.new
  end

  def edit
  end

  def create
    @partner = Partner.new(partner_params)

    respond_to do |format|
      if @partner.save
        format.html { redirect_to admin_partners_url(:cat => @partner.section_id), notice: 'Samarbeidspartner er lagt til.' }
        format.json { render :show, status: :created, location: @partner }
      else
        format.html { render :new }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @partner.update(partner_params)
        format.html { redirect_to admin_partners_url(:cat => @partner.section_id), notice: 'Samarbeidspartner er oppdatert.' }
        format.json { render :show, status: :ok, location: @partner }
      else
        format.html { render :edit }
        format.json { render json: @partner.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @partner.destroy
    respond_to do |format|
      format.html { redirect_to admin_partners_url(:cat => @partner.section_id), notice: 'Samarbeidspartneren ble slettet.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_partner
      @partner = Partner.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def partner_params
      params.require(:partner).permit(:title, :description, :link, :logo, :ispublished, :section_id)
    end
end
