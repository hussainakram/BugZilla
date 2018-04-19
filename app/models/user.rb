class User < ApplicationRecord

  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_projects
  has_many :projects, through: :user_projects

  def developer?
    user_type == "developer"
  end
  def manager?
    user_type == "manager"
  end
  def qa?
    user_type == "qa"
  end
  def display_name
    name || email
  end
end
