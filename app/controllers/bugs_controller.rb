class BugsController < ApplicationController
  before_action :set_bug, only: %i[show edit update destroy]
  # after_action :verify_authorized, except: :index

  # GET /bugs
  # GET /bugs.json
  def index
    @project = Project.find(params[:project_id])
    @bugs = @project.bugs.all
  end

  # GET /bugs/1
  # GET /bugs/1.json
  def show
    @bug = Bug.find(params[:id])
    @project = Project.find(@bug.project_id)
    @assigned_user = User.find @bug.assign_to if @bug.assign_to.present?
    @audits = @bug.audits if @bug.audits
  end

  # GET /bugs/new
  def new
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new
    @bug.post_id = params[:bug_id] if params[:post_id].present?
  end

  # GET /bugs/1/edit
  def edit
    @user = current_user
    @bug = Bug.find(params[:id])
  end

  # POST /bugs
  # POST /bugs.json
  def create
    @project = Project.find(params[:project_id])
    @bug = @project.bugs.new(bug_params)
    respond_to do |format|
      if @bug.save
        format.html { redirect_to project_bugs_path(@project.id), notice: 'Bug was successfully created.' }
        format.json { render :show, status: :created, location: @bug }
      else
        format.html { render :new }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bugs/1
  # PATCH/PUT /bugs/1.json
  def update
    respond_to do |format|
      if @bug.update(bug_params)
        format.html { redirect_to @bug, notice: 'Bug was successfully updated.' }
        format.json { render :show, status: :ok, location: @bug }
      else
        format.html { render :edit }
        format.json { render json: @bug.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bugs/1
  # DELETE /bugs/1.json
  def destroy
    @bug.destroy
    respond_to do |format|
      format.html { redirect_to projects_path(@bug.project_id), notice: 'Bug was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_comment; end

  def assign
    @bug = Bug.find(params[:id])
    @bug.update(assign_to: current_user.id)
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Bug was has been assigned to you!' }
      format.json { head :no_content }
    end
  end

  def resolve
    @bug = Bug.find(params[:id])
    authorize @bug
    if @bug.is_feature?
      @bug.update(status: 'Completed')
    elsif bug.is_bug?
      @bug.update(status: 'Resolved')
    end
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Bug was has been resolved by you!' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_bug
    @bug = Bug.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def bug_params
    params.require(:bug).permit(:title, :description, :avatar, :post_id, :deadline,
                                :bug_type, :status, :user_id, :project_id)
  end
end
