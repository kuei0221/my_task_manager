class RenameStartAndEndToStartDateAndEndDateToTask < ActiveRecord::Migration[6.1]
  def change
    change_table :tasks do |t|
      t.rename :start, :start_date
      t.rename :end, :end_date
    end
  end
end
