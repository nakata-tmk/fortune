# frozen_string_literal: true

require 'rails_helper'

describe 'Homeコントローラーのテスト' do
  let!(:word) { create(:word) }

  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    context '表示の確認' do
      it '「投稿一覧」が表示されている' do
        expect(page).to have_content '投稿一覧'
      end
      it 'アンケート詳細へのリンクが表示されている' do
        expect(page).to have_link href: word_path(word)
      end
      it 'パスが"/"である' do
        expect(current_path).to eq('/')
      end
    end
  end
  describe 'ソートのテスト' do
    before do
      visit root_path
    end
    context '表示テスト' do
      it 'ソートフォームが表示されている' do
        expect(page).to have_field 'sort'
      end
      it 'ソートリストが表示されている' do
        expect(page).to have_select('sort', options: ['新着順', '古い順', 'いいね順'])
      end
    end
  end
end