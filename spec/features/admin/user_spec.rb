require 'rails_helper'

RSpec.describe 'Admin#User' do
  describe 'Create New User' do
    it do
      visit new_admin_user_path
      fill_in 'Name', with: 'Test Name'
      fill_in 'Password', with: 'password'
      click_on 'Create User'
      expect(page).to have_content 'User Create Success'
      expect(page).to have_current_path admin_users_path
    end
  end

  describe 'Edit User' do
    it do
      visit edit_admin_user_path(id: 1)
      fill_in 'Name', with: 'Test Edit User Name'
      click_on 'Update User'
      expect(page).to have_content 'User Update Success'
      expect(page).to have_current_path admin_users_path
    end
  end

  describe 'Delete User', js: true do
    it do
      visit admin_users_path
      expect(page).to have_text('michael')
      within '#user-1' do
        page.accept_alert 'Do you really want to delete this user?' do 
          click_on 'Delete'
        end
      end
      expect(page).not_to have_text('michael')
    end
  end

  describe 'User index' do
    it 'shows all user' do
      visit admin_users_path
      expect(page).to have_text('michael')
      expect(page).to have_text('guest')
    end
  end
end
