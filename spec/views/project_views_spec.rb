require 'rails_helper'

RSpec.describe 'Projects Views' do
  user = FactoryBot.create(:user, email: Faker::Internet.email, user_type: 'manager')
  before { sign_in(user) }

  describe 'index page' do
    project = user.projects.create(name: Faker::Name.title, description: Faker::Lorem.sentence)
    UserProject.create(user_id: user.id, project_id: project.id)
    it 'renders index page' do
      visit projects_path
      expect(page).to have_content('Projects')
      expect(page).to have_content('New Project')
    end
  end

  describe 'create/update project' do
    before do
      user = create(:user, email: Faker::Internet.email)
    end
    it 'visit new project page' do
      visit new_project_path
      expect(page).to have_content('New Project')
      expect(page).to have_content('Name')
    end
    it 'creates project after filling the form' do
      visit new_project_path
      fill_in 'Name', with: 'my dash project'
      fill_in 'Description', with: Faker::Lorem.sentence
      click_button 'Create'
      expect(page).to have_content('my dash project')
    end
    it 'Update project' do
      project = FactoryBot.create(:project)
      visit edit_project_path(project)
      fill_in 'Name', with: 'my dash dash project'
      fill_in 'Description', with: Faker::Lorem.sentence
      click_button 'Create'
      expect(page).to have_current_path(project_path(project))
      expect(page).to have_content('my dash dash project')
    end
    it 'shows list of Users from a project' do
      project = FactoryBot.create(:project)
      visit project_users_path(project)
      expect(page).to have_content('Users')
    end
  end
end
