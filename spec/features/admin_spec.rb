require 'rails_helper'

RSpec.describe 'Admin' do
  describe 'when user is admin' do
    before { admin_login }

    it 'can access to admin page' do
      visit admin_users_path
      expect(page).to have_current_path admin_users_path
    end

    it 'can switch to admin' do
      visit tasks_path
      click_on 'Admin'
      expect(page).to have_current_path admin_users_path
    end

    it 'can switch to normal user' do
      visit admin_users_path
      click_on 'Normal User'
      expect(page).to have_current_path tasks_path
    end
  end

  describe 'when user is not admin' do
    before { login }

    it 'shows error and return to tasks page' do
      visit admin_users_path
      expect(page).to have_text 'You do not have the permission to enter this page'
      expect(page).to have_current_path tasks_path
    end

    it 'cannot find admin button' do
      visit tasks_path
      expect(page).not_to have_content('Admin')
    end
  end

  describe 'when user is not login' do
    it 'asks user to login first' do
      visit admin_users_path
      expect(page).to have_text 'please login first'
    end

    it 'cannot find admin button' do
      visit tasks_path
      expect(page).not_to have_content('Admin')
    end
  end
end
