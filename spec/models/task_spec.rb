# require 'rails_helper'
# RSpec.describe 'タスクモデル機能', type: :model do
#   describe 'バリデーションのテスト' do
#     context 'タスクのタイトルが空の場合' do
#       it 'バリデーションにひっかる' do
#         task = Task.new(title: '', details: '失敗テスト')
#         expect(task).not_to be_valid
#       end
#     end
#   end
#     context 'タスクの詳細が空の場合' do
#       it 'バリデーションにひっかかる' do
#         task = Task.new(title: '失敗テスト', details: ' ')
#         expect(task).not_to be_valid
#       end
#     end
#     context '終了期限がない場合' do
#       it 'バリデーションに引っかかる' do 
#         task = Task.new(title:'失敗テスト', time_limit:'')
#         expect(task).not_to be_valid
#       end
#     end
#     context 'ステータスがない場合' do
#       it 'バリデーションに引っかかる' do 
#         task = Task.new(title:'失敗テスト',completed:'')
#         expect(task).not_to be_valid
#       end
#     end
#     context 'タスクのタイトル・詳細・終了期限・ステータス・優先度がある場合' do
#       it 'バリデーションが通過する' do
#         task = Task.new(title:'成功タイトル名',details:'成功詳細',time_limit:'2000-01-01',completed:'完了',priority:'高')
#         expect(task).to be_valid
#       end
#     end
#     context '優先度がない場合' do
#       it 'バリデーションに引っかかる' do
#         task = Task.new(title:'失敗テスト',priority:'')
#         expect(task).not_to be_valid 
#       end
#     end

# describe '検索機能'do
#     context 'タイトルであいまい検索をした場合' do
#         it '検索キーワードを含むタスクで絞り込まれる' do 
#             task = Task.create(title:'テスト1',details:'詳細1',time_limit:'2000-01-01',completed:'未着手', priority:'高')
#             second_task = Task.create(title:"テスト2",details:'詳細2',time_limit:'2000-01-01',completed:'完了', priority:'高')
#             expect(Task.search_title('テスト1')).to include(task)
#             expect(Task.search_title('テスト1')).not_to include(second_task)
#             expect(Task.search_title('テスト1').count).to eq 1
#         end
#     end
#     context'ステータスを検索した場合' do
#         it 'ステータスに完全一致するタスクが絞り込まれる'do 
#             task = Task.create(title:'テスト1',details:'詳細1',time_limit:'2000-01-01',completed:'未着手', priority:'高')
#             second_task = Task.create(title:"テスト2",details:'詳細2',time_limit:'2000-01-01',completed:'完了', priority:'高')
#             expect(Task.search_completed('未着手')).to include(task)
#             expect(Task.search_completed('未着手')).not_to include(second_task)
#             expect(Task.search_completed('未着手').count).to eq 1
#         end
#     end
#     context'タイトルのあいまい検索とステータス検索をした場合' do
#         it '検索キーワードにタイトルを含み、かつステータスに一致するタスクに絞り込まれる'do
#             task = Task.create(title:'テスト1',details:'詳細1',time_limit:'2000-01-01',completed:'未着手', priority:'高')
#             second_task = Task.create(title:"テスト2",details:'詳細2',time_limit:'2000-01-01',completed:'完了', priority:'高')
#             expect(Task.search_title('テスト1')).to include(task)
#             expect(Task.search_completed('未着手')).to include(task)
#             expect(Task.search_title('テスト1').count).to eq 1
#         end
#     end
#   end
# end
  
