class RemoveTaskIdUserIdFromLabels < ActiveRecord::Migration[5.2]
  def change
    remove_column :labels, :user_id, :integer
    remove_column :labels, :task_id, :integer
  end
end
