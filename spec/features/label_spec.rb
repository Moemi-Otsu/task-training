require 'rails_helper'

RSpec.feature "タスク管理機能", type: :feature do
  
  background do
    # ラベル
    @label1 = create(:label)
    @label2 = create(:second_label)
    @label3 = create(:third_label)
    # タスク
    @user = create(:user)
    FactoryBot.create(:task, user_id: @user.id, labels_on_task: [@label1, @label2])
    FactoryBot.create(:second_task, user_id: @user.id, labels_on_task: [@label3])
    FactoryBot.create(:third_task, user_id: @user.id, labels_on_task: [@label1])
    @second_user = create(:second_user)
  end

  scenario "新規ラベル作成できているか（admin権限）" do
    user_login_factory
    click_on 'ラベル作成'
    fill_in 'label[label_name]', with: 'ラベルテスト100'
    click_on '新規作成'
    expect(page).to have_content 'ラベルテスト100'
  end

  scenario "複数のラベルが付与できているか" do
    user_login_factory
    visit new_task_path
    fill_in 'title', with: 'タスクタイトル'
    fill_in 'content', with: 'タスクコンテンツ'
    fill_in 'deadline', with: '2019-07-27'
    select '未着手', from: 'task_status'
    select '低', from: 'task_priority'
    check 'ラベル2'
    check 'ラベル3'
    click_on '投稿する'
    expect(page).to have_content 'ラベル2'
    expect(page).to have_content 'ラベル3'
  end

  scenario "ラベル検索が動作しているか" do
    user_login_factory
    visit tasks_path
    check 'ラベル1'
    check 'ラベル2'
    click_on('label_search')
    task = all('tr')
    expect(task[1]).to have_content('ラベル1')
    expect(task[1]).to have_content('ラベル2')
    expect(task[2]).to have_content('ラベル1')
  end

  private

  def user_login_factory
    visit new_session_path
    fill_in 'session_email', with: @user.email
    fill_in 'session_password', with: @user.password
    click_on 'commit'
  end

end