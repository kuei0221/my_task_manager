class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  has_secure_password

  validates :name, presence: true, uniqueness: true
  validates :password_digest, presence: true

  before_destroy :last_admin_user?, if: :admin?

  private

  def last_admin_user?
    raise LastAdmin, I18n.t('user.last_admin_error') if User.where(admin: true).size == 1
  end

  class LastAdmin < StandardError; end
end
