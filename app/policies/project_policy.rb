class ProjectPolicy < ApplicationPolicy
  def destroy?
    user.user_type == "manager"
  end

  def update?
    user.user_type == "manager"
  end

  # class Scope
  #   def resolve
  #     scope.where(user_id: @user.id)
  #   end
  # end
end
