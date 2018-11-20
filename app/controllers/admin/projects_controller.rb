class Admin::ProjectsController < Admin::ApplicationController
  before_action :set_admin_project, only: [:show, :edit, :update, :destroy]

 
  def index
    @projects = Project.order(id: :desc)
 
  end

  def show
  end

  def new
    @project = Project.new
  end

  def edit
  end

  def create
    @project = Project.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to admin_projects_url(:cat => @project.section_id), notice: 'Prosjektet er lagt til.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to admin_projects_url(:cat => @project.section_id), notice: 'Project was successfully updated.' }
        
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to admin_projects_url(:cat => @project.section_id), notice: 'Prosjektet ble slettet.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:title, :summary, :content, :image, :ispublished, :section_id)
    end
end
