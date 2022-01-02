# frozen_string_literal: true

require 'rails_helper'

describe '管理者：Wordコントローラーのテスト' do
  let!(:admin) { create(:admin) }
  let!(:word) { create(:word) }
  before do
    visit admin_login_path
    fill_in 'admin[email]', with: admin.email
    fill_in 'admin[password]', with: admin.password
    find('input[name="commit"]').click
    visit admin_word_path(word)
  end

  describe '詳細画面のテスト' do
    context '表示の確認' do
      it '「投稿詳細」が表示されている' do
        expect(page).to have_content '投稿詳細'
      end
      it '削除リンクが表示されている' do
        expect(page).to have_link '削除', href: admin_word_path(word)
      end
    end
    context '削除のテスト' do
      before do
        click_link '削除'
      end
      it '正しく削除される' do
        expect(Word.where(id: word.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/admin'
      end
    end
  end
end