class Admin::FaqsController < Admin::ApplicationController
  before_action :set_admin_faq, only: [:show, :edit, :update, :destroy]

 
  def index
    @faqs = Faq.order(id: :asc)
 
  end

  def show
  end

  def new
    @faq = Faq.new
  end

  def edit
  end

  def create
    @faq = Faq.new(faq_params)

    respond_to do |format|
      if @faq.save
        format.html { redirect_to admin_faqs_url(:cat => @faq.section_id), notice: 'Spørsmål er lagt til.' }
        format.json { render :show, status: :created, location: @faq }
      else
        format.html { render :new }
        format.json { render json: @faq.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @faq.update(faq_params)
        format.html { redirect_to admin_faqs_url(:cat => @faq.section_id), notice: 'Spørsmålet ble oppdatert.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @faq.destroy
    respond_to do |format|
      format.html { redirect_to admin_faqs_url(:cat => @faq.section_id), notice: 'Spørsmålet ble slettet.' }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_faq
      @faq = Faq.find(params[:id])
    end

    def faq_params
      params.require(:faq).permit(:question, :answer, :section_id)
    end
end
