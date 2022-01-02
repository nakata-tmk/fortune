# frozen_string_literal: true

require 'rails_helper'

describe 'Wordコントローラーのテスト' do
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
  describe '新規投稿画面のテスト' do
    context '新規作成成功のテスト' do
      before do
        visit new_word_path
        fill_in 'word[body]', with: Faker::Lorem.characters(number: 20)
      end
      it '新しい投稿が正しく保存される' do
        expect { click_on '投稿' }.to change{Word.count}.by(1)
      end
      it 'リダイレクト先が、トップ画面になっている' do
        click_on '投稿'
        expect(current_path).to eq root_path
      end
      it 'メッセージが表示される' do
        click_on '投稿'
        expect(find('#notice', visible: false).text(:all)).to include '新規作成しました'
      end
    end
    context '新規作成失敗のテスト' do
      before do
        visit new_word_path
        fill_in 'word[body]', with: ''
      end
      it '新しい投稿が保存されない' do
        expect { click_on '投稿' }.not_to change(Word.all, :count)
      end
      it 'リダイレクト先が、一覧画面になっている' do
        click_on '投稿'
        expect(current_path).to eq words_path
      end
      it 'メッセージが表示される' do
        click_on '投稿'
        expect(find('#message', visible: false).text(:all)).to include '入力してください'
      end
    end
  end
  describe '詳細画面のテスト' do
    context '詳細画面：表示の確認' do
      before do
        visit word_path(word)
      end
      it '「投稿内容」が表示されている' do
        expect(page).to have_content '投稿内容'
      end
      it '「コメント」が表示されている' do
        expect(page).to have_content 'コメント'
      end
      it '「いいね」が表示されている' do
        expect(page).to have_content 'いいね'
      end
    end
  end
end