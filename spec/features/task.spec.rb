require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    # Task.create!(title: 'タイトルa', content: 'コンテンツa')
    # Task.create!(title: 'タイトルb', content: 'コンテンツb')
  end

  scenario "タスク一覧のテスト" do
    # background do の内容が先に実行される
  
    visit tasks_path
    # visit "/tasks"
    # visit root_path

    # テスト処理を止めてviewページを表示ことができる
    # save_and_open_page
  
    expect(page).to have_content 'コンテンツa'
    expect(page).to have_content 'コンテンツb'
  end

  scenario "新規投稿テスト" do
    # new_task_pathにvisitする（タスク登録ページに遷移する）
    visit new_task_path

    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    fill_in 'title', with: 'これはタイトルのテスト'
    fill_in 'content', with: 'これはコンテンツ内容テスト' 

    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '投稿する'

    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    expect(page).to have_content 'これはコンテンツ内容テスト'
  end

  scenario "一覧ページから詳細ページへの遷移" do
    # background do の内容が先に実行される
    visit tasks_path
    #save_and_open_page
    click_link '詳細'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
  end

end