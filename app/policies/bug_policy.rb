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
  def assign?
    user.developer?
  end
  def destroy?
    user.manager? or user.qa?
  end
  def new?
    user.manager? or user.qa?
  end
  def resolve?
    user.developer?
  end
end
