class CreateLabel < ActiveRecord::Migration[6.1]
  def change
    create_table :labels do |t|
      t.string :name, index: true, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
