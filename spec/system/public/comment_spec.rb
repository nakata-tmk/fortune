# frozen_string_literal: true

require 'rails_helper'

describe 'Commentコントローラーのテスト' do
  let!(:word) { create(:word) }
  before do
    visit word_path(word)
  end

  context '新規作成成功のテスト' do
    before do
      fill_in 'comment[body]', with: Faker::Lorem.characters(number: 20)
    end
    it '新しい投稿が正しく保存される' do
      expect { click_on 'コメント' }.to change{word.comments.count}.by(1)
    end
    it 'リダイレクト先が、詳細画面になっている' do
      click_on 'コメント'
      expect(current_path).to eq word_path(word)
    end
    it 'メッセージが表示される' do
      click_on 'コメント'
      expect(find('#notice', visible: false).text(:all)).to include 'コメントしました'
    end
  end
  context '新規作成失敗のテスト' do
    before do
      fill_in 'comment[body]', with: ''
    end
    it '新しい投稿が保存されない' do
      expect { click_on 'コメント' }.not_to change(word.comments, :count)
    end
    it 'リダイレクト先が、詳細画面になっている' do
      click_on 'コメント'
      expect(current_path).to eq  word_comments_path(word)
    end
    it 'メッセージが表示される' do
      click_on 'コメント'
      expect(find('#message', visible: false).text(:all)).to include 'コメント文を入力してください'
    end
  end
end