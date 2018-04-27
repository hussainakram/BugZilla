class Users::InvitationsController < Devise::InvitationsController
  after_action :add_user_to_project
  before_action :update_sanitized_params, only: :update

  # PUT /resource/invitation
  def update
    respond_to do |format|
      format.js do
        invitation_token = Devise.token_generator.digest(resource_class, :invitation_token,
                                                         update_resource_params[:invitation_token])
        self.resource = resource_class.where(invitation_token: invitation_token).first
        resource.skip_password = true
        resource.update update_resource_params.except(:invitation_token)
      end
      format.html do
        super
      end
    end
  end

  private

  def add_user_to_project
    @user&.user_projects&.create(project_id: params[:project_id])
  end

  def invite_resource
    user = User.last
    resource_class.invite!(invite_params, current_inviter) do |invitable|
      invitable.update!(user_type: invite_params[:user_type])
      user.user_projects.first_or_create!(project_id: params[:project_id])
    end
  end

  def invite_params
    params.require(:user).permit(:name, :email, :project_id, :invitation_token, :user_type)
  end

  def update_sanitized_params
    devise_parameter_sanitizer.permit(:accept_invitation,
                                      keys: %i[name password password_confirmation invitation_token])
  end
end
