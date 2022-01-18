require 'rails_helper'
RSpec.describe 'ラベル機能', type: :system do 
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    let!(:label){FactoryBot.create(:label)}
    let!(:second_label){FactoryBot.create(:second_label)}
    before do
        visit new_session_path 
        fill_in 'session_email', with: 'test@test.com'
        fill_in 'session_password', with: 'password'
        click_on 'Log in'
    end
describe 'ラベル検索機能' do
  context 'ラベルを新規作成した場合' do
    it '作成したタスクにラベルが含まれている' do
        visit new_task_path
        fill_in 'task[title]', with: 'ラベル'
        fill_in 'task[details]', with: 'ラベル検証'
        select '高', from: 'task[priority]'
        select '未着手', from: 'task[completed]'
        check 'label1'
        click_on '登録する'
        expect(page).to have_content 'label1'
    end
  end
  context 'ラベル検索をした場合' do
    it '検索したラベルのタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'ラベル'
        fill_in 'task[details]', with: 'ラベル検証'
        select '高', from: 'task[priority]'
        select '未着手', from: 'task[completed]'
        check 'label1'
        click_on '登録する'
        visit tasks_path
        select'label1', from:'task[label_id]'
        click_on 'Search' 
        expect(page).to have_content 'label1'
        expect(page).to have_content 'ラベル'
    end
  end
  context 'ラベルを編集した場合' do
    it '編集したラベルが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'ラベル'
        fill_in 'task[details]', with: 'ラベル検証'
        select '高', from: 'task[priority]'
        select '未着手', from: 'task[completed]'
        check 'label1'
        click_on '登録する'
        visit tasks_path
        visit edit_task_path(task.id)
        check 'label2'
        click_on '更新する'
        expect(page).to have_content 'label1'
        expect(page).to have_content 'label2'
    end
  end



end
end
