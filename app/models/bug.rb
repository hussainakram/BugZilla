class Bug < ApplicationRecord
  attr_accessor :avatar, :remote_avatar_url
  after_create -> { save_audit('Create') }
  before_update -> { save_audit('Update') }
  before_destroy -> { save_audit('Destroy') }

  mount_uploader :avatar, AvatarUploader
  serialize :avatars, JSON
  validates :title, uniqueness: true, presence: true
  validates :bug_type, presence: true
  validates :status, presence: true

  has_many :audits, dependent: :destroy
  belongs_to :user
  belongs_to :sprint
  belongs_to :project
  belongs_to :post, class_name: 'Bug'
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
    a = Audit.new(bug_id: id, user_id: user_id)
    if action == 'Update'
      if title_changed?
        a.update(changed_attribute: 'Title', previous_value: changes[:title][0], new_value: changes[:title][1])
        a.increment(:version, 1)
      elsif description_changed?
        a.update(changed_attribute: 'Description', previous_value: changes[:description][0], new_value: changes[:description][1])
        a.increment(:version, 1)
      elsif deadline_changed?
        a.update(changed_attribute: 'Deadline', previous_value: changes[:deadline][0], new_value: changes[:deadline][1])
        a.increment(:version, 1)
      elsif bug_type_changed?
        a.update(changed_attribute: 'Bug type', previous_value: changes[:bug_type][0], new_value: changes[:bug_type][1])
        a.increment(:version, 1)
      elsif status_changed?
        a.update(changed_attribute: 'Status', previous_value: changes[:status][0], new_value: changes[:status][1])
        a.increment(:version, 1)
      elsif avatar_changed?
        a.update(changed_attribute: 'Avatar', previous_value: changes[:avatar][0], new_value: changes[:avatar][1])
        a.increment(:version, 1)
      end
      a.update(action_performed: 'Update')
    else
      a.increment(:version, 1)
      a.update(action_performed: action)
    end
  end
end
