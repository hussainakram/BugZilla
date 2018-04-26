require 'rails_helper'

RSpec.describe 'Bug Views' do
  user = FactoryBot.create(:user, user_type: "manager")
  before { sign_in(user) }

  describe "Bug flow" do
    project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence)
    bug = project.bugs.create(
        title: Faker::Science.element,
        description: Faker::Lorem.sentences,
        deadline: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today),
        bug_type: "feature",
        status: "Started"
      )
    it 'renders index page' do
      user = FactoryBot.create(:user, user_type: "manager")
      project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence, user_id: user.id)
      bug = project.bugs.create(
        title: Faker::Science.element,
        description: Faker::Lorem.sentences,
        deadline: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today),
        bug_type: "feature",
        status: "Started",
        user_id: user.id
      )
      visit project_bugs_path(project)
      expect(page).to have_content('Bugs')
      expect(page).to have_content(project.name)
    end
  end

  describe "create/update" do
    before do
      user = create(:user, email: Faker::Internet.email)
    end
    it "visit #new_action page" do
      user = FactoryBot.create(:user, user_type: "manager")
      project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence, user_id: user.id)
      visit new_project_bug_path(project)
      expect(page).to have_content('New Bug')
    end
    it "creates after filling the form" do
      user = FactoryBot.create(:user, user_type: "manager")
      project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence, user_id: user.id)
      visit new_project_bug_path(project)
      fill_in "Title", with: "my dash bug"
      fill_in "Description", with: Faker::Lorem.sentence
      fill_in "Deadline", with: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
      page.find(:select, "bug_type").first(:option, "Feature").select_option
      page.find(:select, "bug_status").first(:option, "Completed").select_option
      click_button "Create"
      expect(page).to have_content('my dash bug')
    end

    it "Update bug" do
      user = FactoryBot.create(:user, user_type: "manager")
      project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence, user_id: user.id)
      bug = project.bugs.create(
        title: Faker::Science.element,
        description: Faker::Lorem.sentences,
        deadline: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today),
        bug_type: "feature",
        status: "Started",
        user_id: user.id
      )
      visit edit_bug_path(bug)
      fill_in "Title", with: "my dashsh da bug"
      fill_in "Description", with: Faker::Lorem.sentence
      fill_in "Deadline", with: Faker::Date.between_except(1.year.ago, 1.year.from_now, Date.today)
      page.find(:select, "bug_bug_type").first(:option, "Bug").select_option
      page.find(:select, "bug_bug_status").first(:option, "Started").select_option
      click_button "Update Project"
      expect(page).to have_content('my dashsh da bug')
    end
  end
end
