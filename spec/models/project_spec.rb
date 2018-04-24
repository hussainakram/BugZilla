require 'rails_helper'

RSpec.describe Project, type: :model do


  context "validations test" do
    it { is_expected.to validate_presence_of(:name) }
    it { should belong_to(:user) }
  end
  context "relation testing" do
    it { should have_many(:bugs).dependent(:destroy) }
    it { should have_many(:user_projects).dependent(:destroy) }
    it { should have_many(:users).through(:user_projects) }
  end
end
