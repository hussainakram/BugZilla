class Bug < ApplicationRecord
  attr_accessor :avatar, :remote_avatar_url
  after_create -> { save_audit("Create") }
  before_update -> { save_audit("Update") }
  before_destroy -> { save_audit("Destroy") }

  mount_uploader :avatar, AvatarUploader
  serialize :avatars, JSON
  validates :title, uniqueness: true, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  has_many :audits
  belongs_to :user
  belongs_to :project
  belongs_to :post, class_name: 'Bug'
  has_many :comment, class_name: 'Bug', foreign_key: 'post_id', dependent: :destroy

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

  def save_audit(action)
    a = Audit.new(bug_id: self.id, user_id: self.user_id)
    if action == "Update"
      if title_changed?
        a.update_attribute(:changed_attribute, "Title")
        a.increment(:version, 1)
      elsif description_changed?
        a.update_attribute(:changed_attribute, "Description")
        a.increment(:version, 1)
      elsif deadline_changed?
        a.update_attribute(:changed_attribute, "Deadline")
        a.increment(:version, 1)
      elsif bug_type_changed?
        a.update_attribute(:changed_attribute, "Bug type")
        a.increment(:version, 1)
      elsif status_changed?
        a.update_attribute(:changed_attribute, "Status")
        a.increment(:version, 1)
      elsif status_changed?
        a.update_attribute(:changed_attribute, "Status")
        a.increment(:version, 1)
      elsif avatar_changed?
        a.update_attribute(:changed_attribute, "Avatar")
        a.increment(:version, 1)
      end
      a.update_attribute(:action_performed, "Update")
      a.save
    else
      a.update_attribute(:action_performed, action)
      a.increment(:version, 1)
      a.save
    end
  end
end
