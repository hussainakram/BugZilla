require 'rails_helper'

RSpec.describe User, type: :model do


  context "validations test" do
    let(:user) { build(:user) }

    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
  end
  context "relation testing" do
    it { should have_many(:user_projects).dependent(:destroy) }
    it { should have_many(:projects).through(:user_projects) }
  end
end
