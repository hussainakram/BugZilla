class ProjectPolicy < ApplicationPolicy
  def destroy?
    user.manager?
  end

  def update?
    user.manager?
  end

  # class Scope
  #   def resolve
  #     scope.where(user_id: @user.id)
  #   end
  # end
end
