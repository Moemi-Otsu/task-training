require 'rails_helper'

describe Task do

  # タイトルがなければ無効な状態であること
  # task.valid?メソッドを実行し、失敗すると、taskインスタンスの中にエラーメッセージが入ること
  it "is invalid without a title" do
    task = Task.new(title: nil)
    task.valid?
    expect(task.errors[:title]).to include("を入力してください")
  end

  # 重複したタイトルなら無効な状態であること
  it "is invalid with a duplicate title" do
    Task.create(
      title: 'タイトルA',
      content: 'コンテンツAコンテンツAコンテンツA')
    task =  Task.new(
      title: 'タイトルA',
      content: 'コンテンツAコンテンツAコンテンツA')
    task.valid?
    expect(task.errors[:title]).to include("はすでに存在します")
  end

  # タイトルが101文字以上なら無効な状態であること
  it "is invalid with title is 101 or more characters" do
    task = Task.new(title: 'タイトル' * 101)
    task.valid?
    expect(task.errors[:title]).to include("は101文字以内で入力してください")
  end

end