require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do

  scenario "タスク一覧のテスト" do
    Task.create!(title: 'タイトルc', content: 'コンテンツc')
    Task.create!(title: 'タイトルd', content: 'コンテンツd')
  
    visit tasks_path
    # visit "/tasks"
    # visit root_path

    # save_and_open_page
  
    expect(page).to have_content 'コンテンツc'
    expect(page).to have_content 'コンテンツd'
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
    Task.create!(title: 'タイトルa', content: 'コンテンツa')
    visit tasks_path
    #save_and_open_page
    click_link '詳細'
  end
end