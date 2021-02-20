class ChangeTypeOfPriorityFromStringToInteger < ActiveRecord::Migration[6.1]
  def up
    change_column_default :tasks, :priority, nil
    change_column :tasks, :priority, 'integer USING (CASE priority WHEN \'low\' THEN 0::integer WHEN \'medium\' THEN 1::integer WHEN \'high\' THEN 2::integer END)'
    change_column_default :tasks, :priority, 0
  end

  def down
    change_column_default :tasks, :priority, nil
    change_column :tasks, :priority, 'varchar USING (CASE priority WHEN 0::integer THEN \'low\' WHEN 1::integer THEN \'medium\' WHEN 2::integer THEN \'high\' END)'
    change_column_default :tasks, :priority, 'low'
  end
end
