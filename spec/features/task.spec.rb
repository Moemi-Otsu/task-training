require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
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
    fill_in 'deadline', with: '2019-07-27'

    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '投稿する'

    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    expect(page).to have_content 'これはコンテンツ内容テスト'
  end

  scenario "一覧ページから詳細ページへの遷移" do
    # background do の内容が先に実行される
    visit tasks_path
    # save_and_open_page
    # click_link '詳細'
    all('tr')[1].click_link('詳細')
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # background do の内容が先に実行される
    visit tasks_path
    # save_and_open_page
    # ページの要素
    task = all('.task_title')
    expect(task[0]).to have_content('タイトルcタイトルc')
    expect(task[1]).to have_content('タイトルbタイトルb')
    expect(task[2]).to have_content('タイトルaタイトルa')
  end

  scenario "タスクが終了期限の降順に並んでいるかのテスト" do
    # background do の内容が先に実行される
    visit tasks_path
    click_on '終了期限順に表示'
    # save_and_open_page
    task = all('.sort_test_capybara')
    expect(task[0]).to have_content('2019-08-08'.to_date)
    expect(task[1]).to have_content('2019-07-30'.to_date)
    expect(task[2]).to have_content('2019-07-27'.to_date)
  end

  scenario "絞り込み検索titleテスト" do
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    click_on '絞り込み検索'
    task = all('.task_title')
    expect(task[0]).to have_content('タイトルaタイトルa')
  end

  scenario "絞り込み検索statusテスト" do
    visit tasks_path
    select '未着手', from: 'status_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('未着手')
  end

  scenario "絞り込み検索titleとstatus掛け合わせテスト" do
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    select '未着手', from: 'status_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('未着手')
    expect(task[1]).to have_content('タイトルa')
  end

  scenario "優先順位priorityの投稿テスト" do
    visit new_task_path
    fill_in 'title', with: 'これはタイトルのテスト'
    fill_in 'content', with: 'これはコンテンツ内容テスト'
    fill_in 'deadline', with: '2019-07-27'
    select '完了', from: 'task[status]'
    select '高', from: 'task[priority]'

    click_on '投稿する'
    # save_and_open_page
    expect(page).to have_content '高'
  end

end