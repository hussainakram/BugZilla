require 'rails_helper'

RSpec.describe Bug, type: :model do


  context "validation tests" do
    it { is_expected.to validate_presence_of(:title) }
    # it { should validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:bug_type) }
    it { is_expected.to validate_presence_of(:status) }
  end
  context "relation testing" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end
end
