require 'rails_helper'

RSpec.describe User, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_presence_of(:password_digest) }

  describe '#last_admin_user?' do
    before { User.where(admin: true).where.not(name: 'admin').delete_all }

    let(:admin_user) { users('admin') }

    it 'raise error if destroy last admin user' do
      expect { admin_user.destroy }.to raise_error(User::LastAdmin, 'cannot delete last admin user')
    end
  end
end
