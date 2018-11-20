class Admin::SectionsController < Admin::ApplicationController
  before_action :set_admin_section, only: [:show, :edit, :update, :destroy]
 
  def index
    @sections = Section.order(:position)
  end
 
  def reorder
    params[:section].each_with_index do |id, index|
      Section.where(id: id).update_all(position: index + 1)
    end
    head :ok
  end

  def new
    @section = Section.new
  end

  def edit

  end

  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to admin_sections_url, notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to edit_admin_section_url@section, notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to admin_sections_url, notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_admin_section
      @section = Section.find(params[:id])
    end

    def section_params
      params.require(:section).permit(:title, :description, :position, :ispublished)
    end
end
