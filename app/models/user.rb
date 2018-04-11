class User < ApplicationRecord
  enum user_type: [:manager, :developer, :qa]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_projects
  has_many :projects, through: :user_projects
end
