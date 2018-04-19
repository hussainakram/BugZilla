class BugPolicy < ApplicationPolicy
  attr_reader :user, :bug
  def initialize(user, bug)
    @user = user
    @bug = bug
  end

  class Scope < Scope
     def resolve
       if user.admin?
         scope.all
       else
         scope.where(user_id: current_user.id)
       end
     end
   end

  def destroy?
    user.user_type == "manager" or user.user_type == "qa"
  end
  def new?
    user.user_type == "manager" or user.user_type == "qa"
  end
end
