module LoginHelper
  def login
    visit login_path
    fill_in 'Name', with: 'michael'
    fill_in 'Password', with: 'password'
    click_on 'Login'
  end

  def admin_login
    visit login_path
    fill_in 'Name', with: 'admin'
    fill_in 'Password', with: 'password'
    click_on 'Login'
  end
end
