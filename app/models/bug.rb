class Bug < ApplicationRecord
  attr_accessor :avatar, :remote_avatar_url
  mount_uploader :avatar, AvatarUploader
  serialize :avatars, JSON
  validates :title, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  belongs_to :user
  belongs_to :project
  belongs_to :post, class_name: 'Bug'
  has_many :comment, class_name: 'Bug', foreign_key: 'post_id', dependent: :destroy, inverse_of: :bug

  def assigned?
    assign_to.present?
  end

  def is_feature?
    bug_type == 'feature'
  end

  def is_bug?
    bug_type == 'bug'
  end

  def resolved?
    status == 'Resolved' || status == 'Completed'
  end
end
