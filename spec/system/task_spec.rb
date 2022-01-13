require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
    let!(:task){FactoryBot.create(:task)}
    let!(:second_task){FactoryBot.create(:second_task)}
    before do 
        visit tasks_path
    end
    describe '新規作成機能' do
        context 'タスクを新規作成した場合' do
            it '作成したタスクが表示される' do
                visit new_task_path
                fill_in 'タイトル', with: 'テストタイトル'
                fill_in '詳細', with: 'テスト詳細'
                find("#task_time_limit_1i").find("option[value='2011']").select_option
                find("#task_time_limit_2i").find("option[value='4']").select_option
                find("#task_time_limit_3i").find("option[value='1']").select_option
                click_button '登録する'
                expect(page).to have_content 'テストタイトル'
                expect(page).to have_content 'テスト詳細'
                expect(page).to have_content '2011-04-01'
            end
        end
    end
    describe '一覧表示機能' do
        context '一覧画面に遷移した場合' do
            it '作成済みのタスク一覧が表示される' do
                expect(page).to have_content 'test_details'
            end
        end
        context 'タスクが作成日時の降順に並んでいる場合' do
            it '新しいタスクが一番上に表示される' do
                task_list = all('.task_list')
                expect(task_list[0]).to have_content 'test_title2'
                expect(task_list[1]).to have_content 'test_title1'
            end
        end
        context '終了期限でソートするボタンを押した場合' do
            it '終了期限が新しいタスクが一番上に表示される' do
              visit tasks_path
              click_on '終了期限でソートする'
              expect(page).to have_content 'タスク一覧'
              time_limit = all('#dtime_limit')
              expect(deadline[0]).to have_content '2021-01-01'
              expect(deadline[1]).to have_content '2011-01-01'
            end
          end
    end
    describe '詳細表示機能' do
        context '任意のタスク詳細画面に遷移した場合' do
            it '該当タスクの内容が表示される' do
                visit task_path(task)
                expect(page).to have_content 'test_details'
            end
        end
    end
end
    
