class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :name, null: false, index: true
      t.string :description
      t.datetime :start, index: true
      t.datetime :end, index: true
      t.string :status, default: 'pending', index: true
      t.string :priority, default: 'low', index: true

      t.timestamps
    end
  end
end
