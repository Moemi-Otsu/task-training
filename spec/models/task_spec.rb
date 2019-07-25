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
    User.create(
      name: "aaa",
      email: "aaa@mail.com",
      password: "aaaaaa",
      password_confirmation: "aaaaaa")
    Task.create(
      title: 'タイトルA',
      content: 'コンテンツAコンテンツAコンテンツA',
      deadline: '2019-07-18',
      status: '未着手',
      priority: '高',
      user_id: User.first.id)
    task = Task.new(
      title: 'タイトルA',
      content: 'コンテンツAコンテンツAコンテンツA',
      deadline: '2019-07-27',
      status: '着手',
      priority: '高',
      user_id: User.first.id)
    task.valid?
    expect(task.errors[:title]).to include("はすでに存在します")
  end

  # タイトルが101文字以上なら無効な状態であること
  it "is invalid with title is 101 or more characters" do
    task = Task.new(title: 'タイトル' * 101)
    task.valid?
    expect(task.errors[:title]).to include("は101文字以内で入力してください")
  end

  # status_searchでステータスの結果が反映されていること
  it "is status result is reflected in status_search" do
    expect(Task.status_search_param("未着手")).to eq Task.where(status: "未着手")
  end

  # priority_searchでステータスの結果が反映されていること
  it "is priority result is reflected in priority_search" do
    expect(Task.priority_search_param("高")).to eq Task.where(priority: "高")
  end

  # title_searchでの曖昧検索が動作していること
  it "is ambiguous search in title_search is working" do
    expect(Task.title_search_ambiguous("タイトルa")).to eq Task.where("title LIKE?", "%タイトルa%")
  end

end