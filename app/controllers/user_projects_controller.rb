class UserProjectsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @users = @project.users
  end

  def destroy
    UserProject.find(params[:id]).destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'User was successfully removed.' }
      format.json { head :no_content }
    end
  end
end
