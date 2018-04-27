class User < ApplicationRecord
  attr_accessor :current_user
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :email, uniqueness: true, presence: true

  has_many :audits, dependent: :destroy
  has_many :sprints, dependent: :destroy
  has_many :user_projects, dependent: :destroy
  has_many :projects, through: :user_projects

  def self.current
    Thread.current[:user]
  end

  def self.current=(user)
    Thread.current[:user] = user
  end

  def developer?
    user_type == 'developer'
  end

  def manager?
    user_type == 'manager'
  end

  def qa?
    user_type == 'qa'
  end

  def display_name
    name || email
  end
end
