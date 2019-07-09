class AddNotnullToDeadlineOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column :tasks, :deadline, :datetime, default: ' ', null: false
  end
end
