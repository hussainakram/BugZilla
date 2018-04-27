class SprintsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @sprints = @project.sprints
  end

  def new
    @user = current_user
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.new
  end

  def show
    @sprint = Sprint.find params[:id]
    @added_bugs = @sprint.bugs
    bugs = Project.find(@sprint.project_id).bugs
    @unadded_bugs = bugs.where(sprint_id: nil)
  end

  def edit
    @user = current_user
    @sprint = Sprint.find(params[:id])
  end

  def update
    @sprint = Sprint.find params[:id]
    respond_to do |format|
      if @sprint.update(sprint_params)
        format.html { redirect_to @sprint, notice: 'Sprint was successfully updated.' }
        format.json { render :show, status: :ok, location: @sprint }
      else
        format.html { render :edit }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @user = current_user
    @project = Project.find(params[:project_id])
    @sprint = @project.sprints.new(sprint_params)
    respond_to do |format|
      if @sprint.save
        format.html { redirect_to project_sprints_path(@project.id), notice: 'Sprint was successfully created.' }
        format.json { render :show, status: :created, location: @sprint }
      else
        format.html { render :new }
        format.json { render json: @sprint.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy; end

  def add_bug_to
    bug = Bug.find(params[:id])
    sprint = Sprint.find(params[:sprint_id])
    sprint.bugs << bug
  end

  def remove_bug_from
    sprint = Sprint.find(params[:sprint_id])
    bug = sprint.bugs.where(id: params[:id]).first
    bug.update(sprint_id: nil)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def sprint_params
    params.require(:sprint).permit(:name, :start_date, :end_date, :user_id, :project_id)
  end
end
