require 'rails_helper'

RSpec.feature "Users", type: :feature do
  context 'sign up new user' do
    scenario 'should be successful' do
      visit signup_path
      within('form') do
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
      end
      click_button 'Create Account'
      current_path.should == "/"
    end

    scenario 'should fail' do
      visit signup_path
      within('form') do
        fill_in 'user_email', with: 'test@example.com'
        fill_in 'user_password', with: 'abc123'
        fill_in 'user_password_confirmation', with: 'abc123'
      end
      click_button 'Create Account'
      expect(page).to have_content('["Password is too short (minimum is 8 characters)"]')
    end
  end
end
