require 'rails_helper'

feature 'User signs up as Manager' do
  scenario 'See Home Page' do
    visit root_path
    expect(page).to have_content('A Bug Tracking System')
    expect(page).to have_content('Start just right away by Signing Up Now!')
  end

  scenario 'with valid email and password' do
    visit new_user_registration_path
    sign_up_with(Faker::Name.name, Faker::Internet.email, 'password', 'Manager')
    expect(root_path)
    expect(page).to have_content('Create Project')
    expect(page).to have_content('Show Project')
  end

  scenario 'doesnt accept invalid email' do
    visit new_user_registration_path
    sign_up_with(Faker::Name.name, 'Asad', 'password', 'Manager')
    expect(page).to have_content('Sign up')
  end

  scenario 'doesnt accept blank password' do
    visit new_user_registration_path
    sign_up_with(Faker::Name.name, 'Asad', '', 'Manager')
    expect(page).to have_content('Sign up')
  end

  def sign_up_with(user_name, email, password, user_type)
    fill_in 'Name', with: user_name
    fill_in 'Email', with: email
    fill_in 'Password', with: password
    fill_in 'Password confirmation', with: password
    select(user_type, from: 'User type')
    click_button 'Sign up'
  end
end
