class Bug < ApplicationRecord
  enum type: [:feature, :bug]

  validates :title, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  belongs_to :user
  belongs_to :project
end
