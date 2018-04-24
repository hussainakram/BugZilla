class Project < ApplicationRecord
  validates :name, presence: true
  belongs_to :user
  has_many :bugs, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :users, through: :user_projects
end
