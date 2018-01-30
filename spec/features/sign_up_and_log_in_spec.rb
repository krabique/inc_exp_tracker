# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'SignUpsAndLogIns', type: :feature do
  email = 'names@namie.com'
  password = 'abcd1234'
  
  scenario 'a visitor can sign up' do
    expect do
      visit '/users/sign_up'

      within('#new_user') do
        fill_in 'user_email', with: email
        fill_in 'user_password', with: password
        fill_in 'user_password_confirmation', with: password
      end

      click_button 'Sign up'
    end.to change(User, :count).by(1)
  end

  scenario 'a visitor can log in' do
    User.create(email: email, password: password)

    visit '/users/sign_in'

    within('#new_user') do
      fill_in 'user_email', with: email
      fill_in 'user_password', with: password
    end

    click_button 'Log in'

    expect(page).to have_content "Hi, #{email}"
  end
end
