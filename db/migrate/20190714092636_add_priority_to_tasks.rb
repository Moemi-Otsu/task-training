class AddPriorityToTasks < ActiveRecord::Migration[5.2]
  def up
    #add_column(テーブル名 カラム名, タイプ [, オプション])
    add_column :tasks, :priority, :string, default: => '', null: => false
  end
end
