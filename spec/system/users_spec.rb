# require 'rails_helper'

# RSpec.describe "ユーザー新規登録", type: :system do

#   before do
#     @user = FactoryBot.build(:user)
#   end

#   context 'ユーザーが新規登録できるとき' do
#     it '正しい情報を入力すればユーザー新規登録ができてトップページに移動する' do
#       # binding.pry
#       visit root_path
#       # visit_with_http_auth(root_path)
#       # expect(page).to have_content('新規登録')
#       # visit new_user_registration_path
#       # fill_in 'nickname', with: @user.nickname
#       # fill_in 'email', with: @user.email
#       # fill_in 'password', with: @user.password
#       # fill_in 'password-confirmation', with: @user.password_confirmation
#       # fill_in 'last-name', with: @user.last_name
#       # fill_in 'first-name', with: @user.first_name
#       # fill_in 'last-name-kana', with: @user.last_name_kana
#       # fill_in 'first-name-kana', with: @user.first_name_kana
#       # select '1989', from: 'user_birth_day_1i'
#       # select '3', from: 'user_birth_day_2i'
#       # select '9', from: 'user_birth_day_3i'
#       # expect{
#       # find('input[name="commit"]').click
#       # }.to change {User.count}.by(1)
#       # expect(current_path).to eq(root_path)
#       # expect(page).to have_content('ログアウト')
#       # expect(page).to have_no_content('新規登録')
#       # expect(page).to have_no_content('ログイン')
#     end

#   end

#   # context 'ユーザーが新規登録できないとき' do
#   #   it '誤った情報ではユーザー新規登録ができずに新規登録ページへ戻ってくる' do

#   #   end
#   # end

# end
