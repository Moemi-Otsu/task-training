class ChangeDeadlineColumnAddDefaultOnUsers < ActiveRecord::Migration[5.2]
  def up
    #change_column_default(テーブル名, カラム名, 初期値)
    change_column_default :tasks, :deadline, default: ''
  end
end
