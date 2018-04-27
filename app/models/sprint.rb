class Sprint < ApplicationRecord
  belongs_to :user
  has_many :bugs, dependent: :destroy
end
