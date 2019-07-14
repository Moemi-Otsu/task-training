class ChangeDeadlinenColumnAddDefaultOnUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :date, default: '', null: false
  end
end
