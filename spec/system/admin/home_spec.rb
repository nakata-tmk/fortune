# frozen_string_literal: true

require 'rails_helper'

describe '管理者：Homeコントローラーのテスト' do
  let!(:admin) { create(:admin) }
  let!(:word) { create(:word) }
  before do
    visit admin_login_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find('input[name="commit"]').click
  end

  describe 'トップ画面のテスト' do
    context '表示の確認' do
      it '「投稿一覧」が表示されている' do
        expect(page).to have_content '投稿一覧'
      end
      it '投稿詳細へのリンクが表示されている' do
        expect(page).to have_link href: admin_word_path(word)
      end
      it 'パスが"/admin"である' do
        expect(current_path).to eq('/admin')
      end
    end
  end

  describe 'ソートのテス' do
    context '表示のテスト' do
      it 'ソートフォームが表示されている' do
        expect(page).to have_field 'sort'
      end
      it 'ソートリストが表示されている' do
        expect(page).to have_select('sort', options: ['新着順', '古い順', 'いいね順'])
      end
    end
  end
end