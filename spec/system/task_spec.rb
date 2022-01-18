require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do 
    let!(:user) { FactoryBot.create(:user) }
    let!(:task) { FactoryBot.create(:task, user: user) }
    let!(:second_task) { FactoryBot.create(:second_task, user: user) }
    before do
      visit new_session_path 
      fill_in 'session_email', with: 'test@test.com'
      fill_in 'session_password', with: 'password'
      click_on 'Log in'
    end
    describe '新規作成機能' do
        context 'タスクを新規作成した場合' do
            it '作成したタスクが表示される' do
                visit new_task_path
                fill_in 'task[title]',with: 'テストtitle'
                fill_in 'task[details]',with: 'Rspecテスト'
                select '完了', from:'task_completed'
                click_button '登録する'
                expect(page).to have_content '完了'
            end
        end
    end
    describe '一覧表示機能' do
        context '一覧画面に遷移した場合' do
            it '作成済みのタスク一覧が表示される' do
                visit tasks_path
                expect(page).to have_content 'テストタイトル1'
                expect(page).to have_content 'テストタイトル2'
            end
        end
        context 'タスクが作成日時の降順に並んでいる場合' do
            it '新しいタスクが一番上に表示される' do
                visit tasks_path
                task_list = all('.task_list')
                expect(task_list[0]).to have_content 'テストタイトル2'
                expect(task_list[1]).to have_content 'テストタイトル1'
            end
        end
        context '終了期限でソートするボタンを押した場合' do
            it '終了期限が新しいタスクが一番上に表示される' do
                visit tasks_path
                click_on '終了期限でソートする'
                expect(page).to have_content 'タスク一覧'
                time_limit = all('#time_limit')
                expect(time_limit[0]).to have_content '2021-01-01'
                expect(time_limit[1]).to have_content '2011-01-01'
            end
        end
        context '優先順位でソートするボタンを押した場合' do 
            it '優先順位が高いタスクが一番上に表示される'do
                visit tasks_path
                click_on '優先順位でソートする'
                sleep 0.5
                priority = all('#priority')
                expect(priority[0]).to have_content '高'
                expect(priority[1]).to have_content '低'
            end
        end
    end
    describe '詳細表示機能' do
        context '任意のタスク詳細画面に遷移した場合' do
            it '該当タスクの内容が表示される' do
                visit task_path(task)
                expect(page).to have_content 'テストタイトル1'
            end
        end
    end
    describe '検索機能'do
        context 'タイトルであいまい検索をした場合' do
            it '検索キーワードを含むタスクで絞り込まれる' do 
                visit tasks_path
                fill_in 'task[title]',with: 'テストタイトル1'
                select '未着手', from: 'task[completed]'
                click_on 'Search'
                expect(page).to have_content 'テストタイトル1'
            end
        end
        context'ステータスを検索した場合' do
            it 'ステータスに完全一致するタスクが絞り込まれる'do 
                visit tasks_path
                select '未着手', from: 'task[completed]'
                click_on 'Search'
                expect(page).to have_content '未着手'
            end
        end
        context'タイトルのあいまい検索とステータス検索をした場合' do
            it '検索キーワードにタイトルを含み、かつステータスに一致するタスクに絞り込まれる'do
                visit tasks_path
                fill_in 'task[title]',with:'テストタイトル2'
                select '完了',from: 'task[completed]'
                click_on 'Search'
                expect(page).to have_content 'テストタイトル'
                expect(page).to have_content '完了'
            end
        end
    end        
end
    
