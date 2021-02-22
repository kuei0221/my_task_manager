class Label < ApplicationRecord
  belongs_to :user
  has_many :task_labels, dependent: :destroy
  has_many :tasks, through: :task_labels

  scope :not_label_to_task, ->(id) { where.not(id: TaskLabel.where(task_id: id).pluck(:label_id)) }
end
