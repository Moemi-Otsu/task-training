class RenameFromTaskTitleToTitleAndTaskContentToContentOnTasks < ActiveRecord::Migration[5.2]
  def change
    rename_column :tasks, :task_title, :title
    rename_column :tasks, :task_content, :content
  end
end
