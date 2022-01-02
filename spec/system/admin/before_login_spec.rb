# frozen_string_literal: true

require 'rails_helper'

describe '管理者：ログイン前のテスト' do
  describe '管理者ログイン' do
    let!(:admin) { create(:admin) }

    before do
      visit admin_login_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/login'
      end
      it '「管理者ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'admin[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'admin[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        find('input[name="commit"]').click
      end

      it 'ログイン後のリダイレクト先が、管理者トップ画面になっている' do
        expect(current_path).to eq '/admin'
      end
    end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        find('input[name="commit"]').click
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/admin/login'
      end
    end
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:admin) { create(:admin) }

    before do
      visit admin_login_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      find('input[name="commit"]').click
    end

    context 'ヘッダーの表示を確認' do
      it 'Homeリンクが表示される: 左上から0番目のリンクが「Home」である' do
        home_link = find_all('a')[0].native.inner_text
        expect(home_link).to match(/Home/i)
      end
      it 'Admin Topリンクが表示される: 左上から1番目のリンクが「Admin Top」である' do
        admin_top_link = find_all('a')[1].native.inner_text
        expect(admin_top_link).to match(/Admin Top/i)
      end
      it 'ログアウトリンクが表示される: 左上から2番目のリンクが「ログアウト」である' do
        logout_link = find_all('a')[2].native.inner_text
        expect(logout_link).to match(/Logout/i)
      end
    end
  end

  describe '管理者ログアウトのテスト' do
    let(:admin) { create(:admin) }

    before do
      visit admin_login_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      find('input[name="commit"]').click
      logout_link = find_all('a')[2].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてAbout画面へのリンクが存在する' do
        expect(page).to have_link '', href: '/about'
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end

  describe 'ログインしていない場合のアクセス権限のテスト' do
    context 'ログイン画面へリダイレクトする' do
      it '管理者トップ画面' do
        visit admin_top_path
        expect(current_path).to eq '/admin/login'
      end
    end
  end
end