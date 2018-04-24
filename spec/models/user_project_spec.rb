require 'rails_helper'

RSpec.describe UserProject, type: :model do

  context "relation testing" do
    it { should belong_to(:user) }
    it { should belong_to(:project) }
  end
end
