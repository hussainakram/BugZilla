require 'rails_helper'

RSpec.describe Bug, type: :model do
  context 'validation tests' do
    it { is_expected.to validate_presence_of(:title) }
    # it { should validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:bug_type) }
    it { is_expected.to validate_presence_of(:status) }
  end
  context 'relation testing' do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end

  context 'Instance methods' do
    user = FactoryBot.create(:user, user_type: 'manager')
    project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence, user_id: user.id)
    bug = project.bugs.create(
      title: Faker::Science.element,
      description: Faker::Lorem.sentences,
      deadline: Faker::Date.between_except(1.year.ago, 1.year.from_now, Time.zone.today),
      bug_type: 'feature',
      status: 'Started',
      user_id: user.id
    )
    bug.update(bug_type: 'bug')
    bug.save
    it 'is_bug?' do
      expect(bug.is_bug?).to be_truthy
    end
  end
end
