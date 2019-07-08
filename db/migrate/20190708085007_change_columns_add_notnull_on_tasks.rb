class ChangeColumnsAddNotnullOnTasks < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :title, false
    change_column_null :tasks, :created_at, false
    change_column_null :tasks, :updated_at, false
  end
end