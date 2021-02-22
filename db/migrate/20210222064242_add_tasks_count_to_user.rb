class AddTasksCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :tasks_count, :integer, default: 0

    User.pluck(:id).each do |i|
      User.reset_counters(i, :tasks)
    end
  end
end
