class Admin::ContactsController < Admin::ApplicationController
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  def index
    @contacts = Contact.all
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def edit
  end

  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        format.html { redirect_to admin_contacts_path(:cat => @contact.section_id), notice: 'Kontaktperson er lagret.' }
        format.json { render :show, status: :created, location: @contact }
      else
        format.html { render :new }
        format.json { render json: @contact.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @contact.update(contact_params)
        format.html { redirect_to edit_admin_contact_url(:cat => @contact.section_id), notice: 'Kontaktpersont er oppdatert.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @contact.destroy
    respond_to do |format|
      format.html { redirect_to admin_contacts_url(:cat => @contact.section_id), notice: 'Kontaktperson er slettet.' }
      format.json { head :no_content }
    end
  end

  private

    def set_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :email, :telephone, :image, :description, :ispublished, :section_id)
    end
end
