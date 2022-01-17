require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
describe 'ユーザー登録機能'do 
    context 'ユーザー登録した場合'do
      it '作成したユーザーが詳細画面に表示される' do
        visit new_user_path
        fill_in 'user[name]',	with: 'テストユーザー'
        fill_in 'user[email]', with: 'test@test.com'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
        click_on 'commit'
        expect(page).to have_content 'テストユーザー'
      end
    end
    context 'ユーザー登録せずにタスク一覧画面に移動しようとした場合'do
      it 'ログイン画面に戻される'do 
      visit tasks_path 
      expect(page).to have_content 'Log in'
      end
    end
end
describe 'セッション機能' do 
    context 'ログインした場合'do
      it 'ログインに成功すること' do
        user_1 = FactoryBot.create(:user_1)
        visit new_session_path 
        fill_in 'session[email]', with: user_1.email
        fill_in 'session[password]', with: user_1.password
        click_on 'Log in'
        expect(current_path).to eq user_path(user_1)
        end
      end
    context 'ログインした場合'do 
      it '自分の詳細画面にアクセスできる' do 
        user_1 = FactoryBot.create(:user_1)
        visit new_session_path 
        fill_in 'session[email]', with: user_1.email
        fill_in 'session[password]', with: user_1.password
        click_on 'Log in'
        expect(page).to have_content 'ユーザー1'
      end
    end
    context '一般ユーザー他人の詳細ページにアクセスする' do
      it 'タスク一覧画面に遷移する' do 
        user_1 = FactoryBot.create(:user_1)
        visit new_session_path 
        fill_in 'session[email]', with: user_1.email
        fill_in 'session[password]', with: user_1.password
        click_on 'Log in'
        visit user_path(user_1)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログイン時にログアウトボタンを押すと' do 
      it 'ログアウトできること' do 
        user_1 = FactoryBot.create(:user_1)
        visit new_session_path 
        fill_in 'session[email]', with: user_1.email
        fill_in 'session[password]', with: user_1.password
        click_on 'Log in'
        click_on 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
end
end
describe '管理画面' do 
    context '管理ユーザーが管理者画面へアクセスすると' do 
      it '管理画面（ユーザー一覧）にアクセス出来る' do
        FactoryBot.create(:user_2)
        visit new_session_path
        fill_in 'session[email]', with: 'user_2@test.com'
        fill_in 'session[password]', with: '222222'
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content "管理者"
      end
    end
    context '一般ユーザーが管理画面にアクセスすると'do 
      it '管理画面にアクセス出来ない' do 
        user_1 = FactoryBot.create(:user_1)
        visit new_session_path 
        fill_in 'session[email]', with: user_1.email
        fill_in 'session[password]', with: user_1.password
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content "管理者以外はアクセス出来ません!"
      end
    end
    context '管理ユーザが新規登録すると' do 
      it '新規ユーザーが登録出来る' do
        FactoryBot.create(:user_2)
        visit new_session_path
        fill_in 'session[email]', with: 'user_2@test.com'
        fill_in 'session[password]', with: '222222'
        click_on 'Log in'
        visit admin_users_path
        click_on "ユーザー登録"
        fill_in 'user_name', with: 'new_test'
        fill_in 'user_email', with: 'new_test@test.com'
        fill_in 'user_password', with: '123456'
        fill_in 'user_password_confirmation', with: '123456'
        click_on "登録する"
        expect(page).to have_content "new_test@test.com"
      end
    end
    context '管理ユーザが詳細画面のリンクボタンを押すと' do 
      it '登録ユーザーの詳細画面にアクセス出来る' do 
        user_1 = FactoryBot.create(:user_1)
        user_2 = FactoryBot.create(:user_2)
        visit new_session_path
        fill_in 'session[email]', with: 'user_2@test.com'
        fill_in 'session[password]', with: '222222'
        click_on 'Log in'
        visit admin_user_path(user_1)
        expect(page).to have_content 'ユーザー1さんのタスク一覧'
      end
    end
    context '管理ユーザが編集画面のリンクボタンを押すと' do 
      it '登録ユーザーの編集画面にアクセス出来る' do 
        user = FactoryBot.create(:user)
        user_1 = FactoryBot.create(:user_1)
        user_2 = FactoryBot.create(:user_2)
        visit new_session_path
        fill_in 'session[email]', with: 'user_2@test.com'
        fill_in 'session[password]', with: '222222'
        click_on 'Log in'
        visit admin_users_path
        # visit edit_admin_user_path(id: user.id)
        visit edit_admin_user_path(user_1)
        fill_in 'user_name', with: 'edit'
        fill_in 'user_email', with: 'edit@test.com'
        fill_in 'user_password', with: '654321'
        fill_in 'user_password_confirmation', with: '654321'
        click_on '更新する'
        expect(page).to have_content 'ユーザーを編集しました!'
      end
    end  
    context '管理ユーザーがユーザーの削除ボタンを押すと' do 
      it 'ユーザーの削除を行える' do 
        user = FactoryBot.create(:user)
        user_1 = FactoryBot.create(:user_1)
        user_2 = FactoryBot.create(:user_2)
        visit new_session_path
        fill_in 'session[email]', with: 'user_2@test.com'
        fill_in 'session[password]', with: '222222'
        click_on 'Log in'
        visit admin_users_path
        click_link '削除', href: admin_user_path(user_1)
        expect {
          page.accept_confirm 'Are you sure？'
          expect(page).to have_content 'ユーザを削除しました'
        }
      end
    end
end
