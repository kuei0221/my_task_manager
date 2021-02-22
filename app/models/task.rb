class Task < ApplicationRecord
  belongs_to :user, counter_cache: true
  has_many :task_labels, dependent: :destroy
  has_many :labels, through: :task_labels

  enum priority: { low: 0, medium: 1, high: 2 }
  validates :name, presence: true
  validates :status, inclusion: { in: %w[pending in_progress completed] }
  validate :start_date_should_not_larger_than_end_date

  scope :search_by_name, ->(name) { where('name like ?', "%#{name}%") }
  scope :search_by_status, ->(status) { where(status: status) }

  paginates_per 50

  def self.search(name: nil, status: nil)
    tasks = all
    tasks = tasks.search_by_name(name) if name.present?
    tasks = tasks.search_by_status(status) if status.present?
    tasks
  end

  def self.order_by(column:, direction:)
    column ||= 'created_at'
    direction ||= 'desc'
    order(column => direction)
  end

  private

  def start_date_should_not_larger_than_end_date
    return unless start_date && end_date && start_date > end_date

    errors.add(:start_date, :bad_start_and_end_date)
  end
end
