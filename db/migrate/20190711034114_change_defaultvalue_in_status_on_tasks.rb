class ChangeDefaultvalueInStatusOnTasks < ActiveRecord::Migration[5.2]
  def up
    change_column_default(tasks, status, '')
  end

  def down
    change_column_default(tasks, status, '未着手')
  end
end
