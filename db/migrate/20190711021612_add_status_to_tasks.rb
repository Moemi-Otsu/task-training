class AddStatusToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :status, :string, default: '未着手', null: false
    add_index :tasks, :status
  end
end
