require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    @user = FactoryBot.create(:user)
    FactoryBot.create(:task, user_id: @user.id)
    FactoryBot.create(:second_task, user_id: @user.id)
    FactoryBot.create(:third_task, user_id: @user.id)
    # Task.create!(title: 'タイトルa', content: 'コンテンツa')
    # Task.create!(title: 'タイトルb', content: 'コンテンツb')
    @second_user = FactoryBot.create(:second_user)
    FactoryBot.create(:fourth_task, user_id: @second_user.id)
  end

  scenario "ユーザー新規登録テスト" do
    user_create
    expect(page).to have_content 'xxxのページ'
  end

  scenario "ユーザ登録（create）をした時、同時にログイン" do
    user_create
    # ログインしていないと、tasks_path（タスク一覧）を見られないので、タスク一覧を見れたらOK
    visit tasks_path
    expect(page).to have_content 'タスク一覧'
  end

  scenario "ログイン画面テスト" do
    user_login_factory
    expect(page).to have_content 'タスク一覧'
  end

  scenario "ログインしていないのにタスクのページに飛ぼうとした場合は、ログインページに遷移" do
    visit tasks_path
    expect(page).to have_content 'ログインしてください。'
  end

  scenario "自分が作成したタスクだけを表示" do
    visit new_session_path
    fill_in 'session_email', with: 'zzz@mail.com'
    fill_in 'session_password', with: 'zzzzzz'
    click_on 'commit'

    visit new_task_path
    fill_in 'title', with: 'タイトルx'
    fill_in 'content', with: 'コンテンツxコンテンツxコンテンツx'
    fill_in 'deadline', with: '2019-08-30'
    select '未着手', from: 'task_status'
    select '低', from: 'task[priority]'
    click_on 'commit'

    visit tasks_path

    page.has_no_text?('タイトルaタイトルa')
    page.has_content?('タイトルx')
  end

  scenario "ログアウト機能確認" do
    visit new_session_path
    fill_in 'session_email', with: 'zzz@mail.com'
    fill_in 'session_password', with: 'zzzzzz'
    click_on 'commit'
    click_on 'ログアウト'
    expect(page).to have_content 'ログアウトしました'
  end

  scenario "ログインしている時は、ユーザー登録画面（new画面）に行かせない" do
    user_login_factory
    visit new_user_path
    expect(page).to have_content 'ログイン'
  end

  scenario "自分（current_user）以外のユーザのマイページ（userのshow画面）に行かせない" do
    user_login_factory
    visit user_path(@user.id)
    # @second_userのnameはyyyなので、以下でログインページにリダイレクトされる
    visit user_path(@second_user.id)
    # リダイレクト先のログインページにが表示されたら成功
    expect(page).to have_content 'ログイン'
  end

  scenario "タスク一覧のテスト" do
    user_login_factory
    visit tasks_path
    expect(page).to have_content 'コンテンツa'
    expect(page).to have_content 'コンテンツb'
  end

  scenario "新規投稿テスト" do
    user_login_factory
    visit tasks_path
    # new_task_pathにvisitする（タスク登録ページに遷移する）
    visit new_task_path

    # 「タスク名」というラベル名の入力欄と、「タスク詳細」というラベル名の入力欄に
    # タスクのタイトルと内容をそれぞれfill_in（入力）する
    fill_in 'title', with: 'これはタイトルのテスト'
    fill_in 'content', with: 'これはコンテンツ内容テスト'
    fill_in 'deadline', with: '2019-07-27'
    select '未着手', from: 'task_status'
    select '高', from: 'task_priority'

    # 4.「登録する」というvalue（表記文字）のあるボタンをclick_onする（クリックする）する処理を書く
    click_on '投稿する'

    # clickで登録されたはずの情報が、タスク詳細ページに表示されているかを確認する
    expect(page).to have_content 'これはコンテンツ内容テスト'
  end

  scenario "一覧ページから詳細ページへの遷移" do
    user_login_factory
    # background do の内容が先に実行される
    visit tasks_path
    # save_and_open_page
    # click_link '詳細'
    all('tr')[1].click_link('詳細')
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    user_login_factory
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
    user_login_factory
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
    user_login_factory
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    click_on '絞り込み検索'
    task = all('.task_title')
    expect(task[0]).to have_content('タイトルaタイトルa')
  end

  scenario "絞り込み検索statusテスト" do
    user_login_factory
    visit tasks_path
    select '未着手', from: 'status_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('未着手')
  end

  scenario "絞り込み検索priorityテスト" do
    user_login_factory
    visit tasks_path
    select '低', from: 'priority_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('低')
  end

  scenario "絞り込み検索titleとstatusとpriority掛け合わせテスト" do
    user_login_factory
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    select '未着手', from: 'status_search'
    select '高', from: 'priority_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('未着手')
    expect(task[1]).to have_content('タイトルa')
    expect(task[1]).to have_content('高')
  end

  scenario "絞り込み検索titleとstatus掛け合わせテスト" do
    user_login_factory
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    select '未着手', from: 'status_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('未着手')
    expect(task[1]).to have_content('タイトルa')
  end

  scenario "絞り込み検索titleとpriority掛け合わせテスト" do
    user_login_factory
    visit tasks_path
    fill_in 'title_search', with: 'タイトルa'
    select '高', from: 'priority_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('高')
    expect(task[1]).to have_content('タイトルa')
  end

  scenario "絞り込み検索statusとpriority掛け合わせテスト" do
    user_login_factory
    visit tasks_path
    select '未着手', from: 'status_search'
    select '高', from: 'priority_search'
    click_on '絞り込み検索'
    task = all('tr')
    expect(task[1]).to have_content('高')
    expect(task[1]).to have_content('未着手')
  end

  scenario "優先順位priorityの新規投稿テスト" do
    user_login_factory
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

  private

  def user_create
    visit new_user_path
    fill_in 'user[name]', with: 'xxx'
    fill_in 'user[email]', with: 'xxx@mail.com'
    fill_in 'user[password]', with: 'xxxxxx'
    fill_in 'user[password_confirmation]', with: 'xxxxxx'
    click_on 'commit'
  end

  def user_login_factory
    visit new_session_path
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: @user.password
    click_on 'commit'
  end

  def user_login_factory_second
    visit new_session_path
    fill_in 'session_email', with: @second_user.email
    fill_in 'session_password', with: @second_user.password
    click_on 'commit'
  end

end