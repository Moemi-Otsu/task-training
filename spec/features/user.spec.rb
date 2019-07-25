require 'rails_helper'

RSpec.feature "ユーザー管理機能", type: :feature do
  
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