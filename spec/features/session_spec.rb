require 'rails_helper'

RSpec.describe 'SessionController' do
  describe 'login' do
    before { visit login_path }
    context 'when name and password are correct' do
      it 'login' do
        fill_in 'Name', with: 'michael'
        fill_in 'Password', with: 'password'
        click_on 'Login'
        expect(page).to have_current_path tasks_path
        expect(page).to have_content 'Login Success'
      end
    end

    context 'when user name not exist' do
      it 'alert error' do
        click_on 'Login'
        expect(page).to have_content 'User Name Not Exist'
      end
    end

    context 'when password wrong' do
      it 'alert error' do
        fill_in 'Name', with: 'michael'
        click_on 'Login'
        expect(page).to have_content 'Password Mismatch'
      end
    end
  end

  describe 'logout' do
    before do
      visit login_path
      fill_in 'Name', with: 'michael'
      fill_in 'Password', with: 'password'
      click_on 'Login'
    end

    it 'logout' do
      click_on 'Logout'
      expect(page).to have_content 'Logout Success'
    end
  end
end
