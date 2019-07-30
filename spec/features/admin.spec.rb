require 'rails_helper'

RSpec.feature "ユーザー管理admin機能", type: :feature do
  
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
    @third_user = FactoryBot.create(:third_user)
  end

  scenario "admin - indexページ表示" do
    user_login_factory
    click_on '管理者メニュー'
    expect(page).to have_content '管理画面ユーザー一覧'
  end

  scenario "admin - ユーザー新規作成" do
    user_login_factory
    visit new_admin_user_path
    fill_in 'user_name', with: 'hoge'
    fill_in 'user_email', with: 'hoge@mail.com'
    fill_in 'user_password', with: 'hogehoge'
    fill_in 'user_password_confirmation', with: 'hogehoge'
    click_on 'commit'
    expect(page).to have_content 'hoge@mail.com'
  end

  scenario "admin - ユーザー詳細画面表示" do
    user_login_factory
    visit admin_users_path
    all('tr')[1].click_link('詳細')
    # ユーザーzzzの詳細ページへ遷移
    expect(page).to have_content 'zzz@mail.com'
  end

  scenario "admin - ユーザー情報更新" do
    user_login_factory
    visit admin_users_path
    all('tr')[1].click_link('編集')
    # ユーザーzzzのeditページへ遷移
    fill_in 'user_name', with: 'hoge'
    fill_in 'user_email', with: 'hoge@mail.com'
    fill_in 'user_password', with: 'hogehoge'
    fill_in 'user_password_confirmation', with: 'hogehoge'
    click_on 'commit'
    expect(page).to have_content 'ユーザー情報を編集しました！'
  end

  scenario "admin - ユーザー削除" do
    user_login_factory
    visit admin_users_path
    all('tr')[2].click_link('削除')
    # ユーザーyyyを削除
    visit admin_users_path
    expect(page).to_not have_content 'yyy@mail.com'
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